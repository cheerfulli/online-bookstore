<template>
  <div style="padding: 10px">
    <div style="margin: 10px 0;">
      <!--    功能区域-->
      <el-button type="primary" round v-on:click="add">新增</el-button>
      <!-- <el-button type="success" round>导入</el-button>
      <el-button type="success" round>导出</el-button> -->
      <!--    搜索区域-->
      <el-button type="primary" icon="el-icon-search" style="margin-outside: 10px; float: right" @click="goSearch">搜索</el-button>
      <el-input v-model="search" placeholder="请输入你搜索的商品的卖点" style="width: 20%; float: right" clearable></el-input>
    </div>

    <!--    表格区域-->
    <el-table
        :data="tableData"
        stripe border
        v-loading="loading"
        style="width: 99%">
      <el-table-column
          prop="id"
          label="商品ID"
          sortable>
      </el-table-column>
      <el-table-column
          prop="title"
          label="商品标题">
      </el-table-column>
      <el-table-column
          prop="sellPoint"
          label="卖点" show-overflow-tooltip>
      </el-table-column>
      <el-table-column
          prop="price"
          label="价格">
      </el-table-column>
      <el-table-column label="商品图片">
        <template #default="scope">
          <el-image
              style="width: 100px; height: 100px"
              :src="scope.row.image"
              :preview-src-list="[scope.row.image]">
          </el-image>
        </template>
      </el-table-column>
      <el-table-column
          prop="stock"
          label="库存数量">
      </el-table-column>
      <el-table-column
          prop="created" sortable
          label="创建时间" width="150px">
      </el-table-column>
      <el-table-column
          prop="updated" sortable
          label="更新时间" width="150px">
      </el-table-column>
      <!--     操作区域-->
      <el-table-column fixed="right" label="操作" align = "center" width="150">
        <template #default="scope">
          <!--          这里scope.row传入直接是传入一行的数据对象，可以使用row.username取出用户名的-->
          <el-button v-on:click="editeClick(scope.row)" type="primary" size="small">编辑</el-button>
          <el-popconfirm title="确定要删除这个商品吗？" @confirm="deleteClick(scope.row.id)" style="margin-left: 10px">
            <template #reference>
            <el-button type="danger" size="small">删除</el-button>
            </template>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>

    <!--    页码区域以及弹出表单-->
    <div style="margin: 20px 0">
      <!--    页码区域,在Vue2里面是不支持v-model:prop="data"的，所以我们要用v-bind:prop.sync="data"实现双向绑定-->
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page.sync="currentPage"
          :page-sizes="[5,10,20]"
          :page-size.sync="pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="totalNumber">
      </el-pagination>

      <!--      添加商品的表单-->
      <el-dialog title="新增/修改商品" :visible.sync="dialogVisible" width="40%">
        <!--        输入表单-->
        <el-form v-bind:model="form" label-width="120px">
          <el-form-item label="商品标题：">
            <el-input v-model="form.title" style="width: 80%"></el-input>
          </el-form-item>
          <el-form-item label="价格：">
            <el-input v-model="form.price" style="width: 80%"></el-input>
          </el-form-item>
          <el-form-item label="库存数量：">
            <el-input v-model="form.stock" style="width: 80%"></el-input>
          </el-form-item>
          <el-form-item label="商品类目：">
            <el-select v-model="form.cid" style="width: 50%">
              <el-option v-for="(item,index) in ['童书','科技','小说','文学','青春文学','艺术','成功励志','管理','历史','哲学']"
                         :key="item" :label="item" :value="index+1"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="商品状态：">
              <el-radio v-model="form.status" :label="1">正常</el-radio>
              <el-radio v-model="form.status" :label="2">下架</el-radio>
              <el-radio v-model="form.status" :label="3">删除</el-radio>
          </el-form-item>
          <el-form-item label="卖点：">
            <el-input type="textarea" v-model="form.sellPoint" style="width: 80%"></el-input>
          </el-form-item>
          <!-- <el-form-item label="商品图片url：">
            <el-input type="textarea" v-model="form.image" style="width: 80%"></el-input>
          </el-form-item> -->
          <el-form-item>
          <el-upload
              class="avatar-uploader"
              action="http://localhost:9090/files/upload"
              :show-file-list="false"
              :on-success="handleAvatarSuccess"
              :before-upload="beforeAvatarUpload">
            <img v-if="form.image" :src="form.image" class="avatar" alt="用户头像">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
          </el-form-item>
        </el-form>
        <!--        下面的按钮-->
        <span slot="footer" class="dialog-footer">
          <el-button @click="dialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="save">确 定</el-button>
        </span>
      </el-dialog>
    </div>
  </div>
</template>

<script>
// @ is an alias to /src
import request from "@/utils/request";

export default {
  name: 'ItemView',
  components: {},
  created() {
    document.title = '商品管理';
    this.loadData();
  },
  methods: {
    // 搜索功能
    goSearch:function (){
      this.loadData();
    },
    // 加载表格数据,Get请求，Get请求不能直接传对象，只有Post可以直接传对象进去
    loadData() {
      this.loading = true;
      request.get("/item", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          search: this.search
        }
      }).then(res => {
        console.log(res);
        this.tableData = res.data.records;
        this.totalNumber = res.data.total;
        this.loading = false;
      })
    },
    // 打开表单栏
    add() {
      // 先清空表单
      this.form = {};
      // 再打开表单
      this.dialogVisible = true;
    },
    // 点击表单的确定按钮，保存数据到后台，Post请求和Put请求
    save() {
      // alert("马上保存/修改~");  使用下面那个elementUI的弹出框
      this.$message({
        type: "info",
        message: "马上保存/修改~"
      })

      if (this.form.id) {
        //   有ID就更新
        request.put("/item",this.form).then(res =>{
          console.log(res);
          if (res.code === '0'){
            this.$message({
              type: "success",
              message: "更新成功"
            })
          }else {
            this.$message({
              type: "error",
              message: res.msg
            })
          }
        })
      }else {
        // 没有就新增
        // 这里不用添加/api，在request.js中我们已经添加了baseurl为api了，然后在vue.config.js中会被拦截
        request.post("/item", this.form).then(res => {
          console.log(res);
          if (res.code === '0'){
            this.$message({
              type: "success",
              message: "新增成功"
            })
          }else {
            this.$message({
              type: "error",
              message: res.msg
            })
          }
        });
      }
      // alert("保存/修改成功");  需要检查之后再看是否成功
      // 更新tableData的数据
      this.loadData();
      this.dialogVisible = false;
    },
    // 修改行数据
    editeClick(row) {
      // 将数据深拷贝过来，避免浅拷贝的修改问题
      this.form = JSON.parse(JSON.stringify(row));
      this.dialogVisible = true;
    },
    // 删除数据
    deleteClick(id) {
      request.delete('/item', {
        params: {
          id : id
        }
      }).then(res=>{
        if (res.code === '0') {
          this.$message({
            type: "warning",
            message: "删除成功",
          })
        }else {
          this.$message({
            type: "error",
            message: res.msg,
          })
        }
      });
      // 更新数据
      this.loadData();
    },
    // 表单每页大小的改变，因为有了双向绑定，直接更新一下数据就好了
    handleSizeChange() {
      this.loadData();
    },
    // 改变当前页码
    handleCurrentChange: function () {
      this.loadData();
    },
    handleAvatarSuccess(res) {
      this.form.image = res.data;
    },
    beforeAvatarUpload(file) {
      const isJPG = file.type === 'image/jpeg';
      const isLt2M = file.size / 1024 / 1024 < 2;

      if (!isJPG) {
        this.$message.error('上传头像图片只能是 JPG 格式!');
      }
      if (!isLt2M) {
        this.$message.error('上传头像图片大小不能超过 2MB!');
      }
      return isJPG && isLt2M;
    }
  },
  data() {
    return {
      // 表单加载中~
      loading: true,
      //新建一个表单，用来储存新增商品和修改商品的数据
      form: {
      },
      // 增加框是否可见
      dialogVisible: false,
      // 总数据数
      totalNumber: 400,
      // 当前页码
      currentPage: 1,
      // 一页多少个
      pageSize: 5,
      // 输入框的数据
      search: '',
      // 表格的数据
      tableData: []
    }
  }
}
</script>
<style scoped>
.avatar-uploader{
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader:hover {
  border-color: #409EFF;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}
.avatar {
  width: 178px;
  height: 178px;
  display: block;
}
</style>