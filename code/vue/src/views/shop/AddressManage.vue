<template>
  <div style="width: 900px;margin: 25px">
    <div style="display: flex;margin: 20px">
      <!--    功能区域-->
      <el-button type="primary" round v-on:click="add">新增</el-button>
      <el-button type="success" round>导入</el-button>
      <el-button type="success" round>导出</el-button>
    </div>

    <!--    表格区域-->
    <el-table
        :data="tableData"
        v-loading="loading"
        stripe border style="height: 500px">
      <el-table-column
          prop="addName"
          label="收货人" align="center">
      </el-table-column>
      <el-table-column
          prop="address"
          label="所在地区">
      </el-table-column>
      <el-table-column
          prop="addDetail"
          label="详细地址" width="300px">
      </el-table-column>
      <el-table-column
          prop="phone"
          label="手机号">
      </el-table-column>
      <!--     操作区域-->
      <el-table-column fixed="right" label="操作" align="center">
        <template #default="scope">
          <!--          这里scope.row传入直接是传入一行的数据对象，可以使用row.username取出用户名的-->
          <el-button v-on:click="editeClick(scope.row)" type="primary" size="small">编辑</el-button>
          <el-popconfirm title="确定删除吗？" @confirm="deleteClick(scope.row.id)" style="margin-left: 10px">
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

      <!--      添加用户的表单-->
      <el-dialog title="新增/修改地址" :visible.sync="dialogVisible" width="40%">
        <!--        输入表单-->
        <el-form v-bind:model="form" label-width="120px">
          <el-form-item label="地址信息：" :rules="[{ required: true}]">
<!--            <el-input v-model="form.address" style="width: 80%" placeholder="请输入地址"></el-input>-->
            <el-cascader filterable clearable
                :options="options" :placeholder="form.address"
                v-model="form.address"
                @change="addressChoose"
            ></el-cascader>
          </el-form-item>
          <el-form-item label="详细地址：" :rules="[{ required: true}]">
            <el-input type="textarea" v-model="form.addDetail" style="width: 80%"
                      placeholder="请输入详细地址信息，如道路、门牌号、小区、楼栋号、单元等信息"></el-input>
          </el-form-item>
          <el-form-item label="收货人姓名：" :rules="[{ required: true}]">
            <el-input v-model="form.addName" style="width: 80%" placeholder="长度不超过25个字符"></el-input>
          </el-form-item>
          <el-form-item label="手机号码：" :rules="[{ required: true}]">
            <el-input v-model="form.phone" style="width: 80%" placeholder="请输入11位手机号"></el-input>
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
import request from "@/utils/request";
import {
  pcaTextArr, // 省市区三级联动数据，纯汉字
} from "element-china-area-data";

export default {
  name: "AddressManage",

  created() {
    document.title = "地址管理"
    //从session中取出登陆者的信息
    let str = sessionStorage.getItem("user") || "{}";
    //解析str
    this.user = JSON.parse(str);
    this.loadData();
  },

  data() {
    return {
      // 选择的地区
      options: pcaTextArr, // 省市区三级联数据，纯汉字
      // 是否在加载
      loading: true,
      //新建一个表单，用来储存新增用户和修改用户的数据
      form: {},
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
      tableData: [],
      // 登录用户
      user: {}
    }
  },

  methods: {
    loadData() {
      this.loading = true
      request.get("/address", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          userId: this.user.id
        }
      }).then(res => {
        this.tableData = res.data.records;
        this.totalNumber = res.data.total;
        this.loading = false;
      })
    },

    add() {
      // 先清空表单
      this.form = {};
      // 再打开表单
      this.dialogVisible = true;
    },


    save() {
      // 在保存前处理一下地址
      this.form.address = this.form.address[0] + " " + this.form.address[1] + " " + this.form.address[2];
      // 判断数据是否合法
      if (this.form.phone.length !== 11){
        this.$message.error("请输入合法的11位手机号")
        return
      }
      this.$message({
        type: "info",
        message: "马上保存/修改~"
      })
      this.form.userId = this.user.id

      if (this.form.id) {
        //   有ID就更新
        request.put("/address", this.form).then(res => {
          console.log(res);
          if (res.code === '0') {
            this.$message({
              type: "success",
              message: "更新成功"
            })
          } else {
            this.$message({
              type: "error",
              message: res.msg
            })
          }
        })
      } else {
        // 没有就新增
        // 这里不用添加/api，在request.js中我们已经添加了baseurl为api了，然后在vue.config.js中会被拦截
        request.post("/address", this.form).then(res => {
          console.log(res);
          if (res.code === '0') {
            this.$message({
              type: "success",
              message: "新增成功"
            })
          } else {
            this.$message({
              type: "error",
              message: res.msg
            })
          }
        });
      }
      // 更新tableData的数据
      location.reload()
    },

    deleteClick(id) {
      request.delete('/address', {
        params: {
          id: id
        }
      }).then(res => {
        if (res.code === '0') {
          this.$message({
            type: "warning",
            message: "删除成功",
          })
        } else {
          this.$message({
            type: "error",
            message: res.msg,
          })
        }
      });
      // 更新数据
      location.reload();
    },

    editeClick(row) {
      // 将数据深拷贝过来，避免浅拷贝的修改问题
      this.form = JSON.parse(JSON.stringify(row));
      this.dialogVisible = true;
    },

    /** 省市区三级联动 */
    addressChoose(value) {
      console.log("##选中的地区", value);
      console.log(this.form.address,"当前的地址")
    },

    // 表单每页大小的改变，因为有了双向绑定，直接更新一下数据就好了
    handleSizeChange() {
      this.loadData();
    },
    // 改变当前页码
    handleCurrentChange: function () {
      this.loadData();
    },
  }
}

</script>

<style scoped>

</style>