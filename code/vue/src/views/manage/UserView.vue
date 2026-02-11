<template>
  <div style="padding: 10px">
    <div style="margin: 10px 0;">
      <!--    功能区域-->
      <el-button type="primary" round v-on:click="add">新增</el-button>
      <!-- <el-button type="success" round>导入</el-button>
      <el-button type="success" round>导出</el-button> -->
      <!--    搜索区域-->
      <el-button type="primary" icon="el-icon-search" style="margin-outside: 10px; float: right" @click="goSearch">搜索</el-button>
      <el-input v-model="search" placeholder="请输入你搜索的用户名"
                @keydown.enter.native="goSearch" style="width: 20%; float: right" clearable>
      </el-input>
    </div>

    <!--    表格区域-->
    <el-table
        :data="tableData"
        v-loading="loading"
        stripe border
        style="width: 99%">
      <el-table-column
          prop="id"
          label="ID"
          sortable>
      </el-table-column>
      <el-table-column
          prop="username"
          label="用户名">
      </el-table-column>

      <el-table-column label="用户类型">
        <!--        这里应该是使用template 和default标签把那个整个data数据取出来，然后scope就是整个数据，每一行数据就是scope.row,tableData=scope-->
        <template #default="scope">
          <span v-if="scope.row.role === 2" style="color: #098486">普通用户</span>
          <span v-if="scope.row.role === 1" style="color: red">管理员</span>
        </template>
      </el-table-column>

      <el-table-column
          prop="nickName"
          label="昵称">
      </el-table-column>
      <el-table-column
          prop="age"
          label="年龄">
      </el-table-column>
      <el-table-column
          prop="sex"
          label="性别">
      </el-table-column>
      <el-table-column
          prop="address"
          label="地址" show-overflow-tooltip>
      </el-table-column>

      <el-table-column width="120px"
          label="头像">
        <template #default="scope">
          <el-image
              style="width: 90px; height: 90px"
              :src="scope.row.avatar"
              :preview-src-list="[scope.row.avatar]">
          </el-image>
        </template>
      </el-table-column>

      <!--     操作区域-->
      <el-table-column fixed="right" label="操作" align = "center">
        <template #default="scope">
          <!--          这里scope.row传入直接是传入一行的数据对象，可以使用row.username取出用户名的-->
          <el-button v-on:click="editeClick(scope.row)" type="primary" size="small">编辑</el-button>
          <el-popconfirm title="这是一段内容确定删除吗？" @confirm="deleteClick(scope.row.id)" style="margin-left: 10px">
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
      <el-dialog title="新增/修改用户" :visible.sync="dialogVisible" width="30%">
        <!--        输入表单-->
        <el-form v-bind:model="form" label-width="120px">
          <el-form-item label="用户名：">
            <el-input v-model="form.username" style="width: 80%"></el-input>
          </el-form-item>
          <el-form-item label="密码：">
            <el-input v-model="form.password" style="width: 80%" type="password"></el-input>
          </el-form-item>
          <el-form-item label="身份：">
              <el-radio v-model="form.role" :label="1">管理员</el-radio>
              <el-radio v-model="form.role" :label="2">用户</el-radio>
          </el-form-item>
          <el-form-item label="昵称：">
            <el-input v-model="form.nickName" style="width: 80%"></el-input>
          </el-form-item>
          <el-form-item label="年龄：">
            <el-input v-model="form.age" style="width: 80%"></el-input>
          </el-form-item>
          <!--          绑定字符串不用：label，绑定数字就要用：label才行-->
          <el-form-item label="性别：">
            <el-radio v-model="form.sex" label="男">男</el-radio>
            <el-radio v-model="form.sex" label="女">女</el-radio>
            <el-radio v-model="form.sex" label="未知">不告诉你</el-radio>
          </el-form-item>
          <el-form-item label="地址：">
            <el-input type="textarea" v-model="form.address" style="width: 80%"></el-input>
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
  name: 'HomeView',
  components: {},
  created() {
    document.title = '用户管理';
    this.loadData();
  },
  methods: {
    // 搜索功能
    goSearch:function (){
      this.loadData();
    },
    // 加载表格数据,Get请求，Get请求不能直接传对象，只有Post可以直接传对象进去
    loadData() {
      this.loading = true
      request.get("/user", {
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
        request.put("/user",this.form).then(res =>{
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
        request.post("/user", this.form).then(res => {
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
      request.delete('/user', {
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
    }
  },
  data() {
    return {
      loading: true,
      //新建一个表单，用来储存新增用户和修改用户的数据
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
