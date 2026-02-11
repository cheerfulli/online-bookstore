<template>
  <div style="padding: 10px">

    <div style="margin: 10px 0;">
      <!--    功能区域-->
      <!-- <el-button type="success" round @click="$message.info('功能待开发')">导入</el-button>
      <el-button type="success" round @click="$message.info('功能待开发')">导出</el-button> -->
      <!--    搜索区域-->
      <el-button type="primary" icon="el-icon-search" style="margin-outside: 10px; float: right" @click="loadData">搜索</el-button>
      <el-input v-model="search" placeholder="请输入你搜索的用户名"
                @keydown.enter.native="loadData" style="width: 20%; float: right" clearable>
      </el-input>
    </div>

    <el-table
        :data="tableData"
        v-loading="loading"
        stripe border
        style="width: 99%"
        :default-sort = "{prop: 'createTime',order: 'descending'}">
      <el-table-column
          prop="userId"
          label="用户ID"
          sortable>
      </el-table-column>
      <el-table-column
          prop="username"
          label="用户名">
      </el-table-column>

      <el-table-column
          prop="nickName"
          label="昵称">
      </el-table-column>

      <el-table-column
          prop="createTime"
          label="建议日期"
          sortable>
      </el-table-column>


      <!--     操作区域-->
      <el-table-column fixed="right" label="操作" align = "center">
        <template #default="scope">
          <!--          这里scope.row传入直接是传入一行的数据对象，可以使用row.username取出用户名的-->
          <el-button v-on:click="handleLook(scope.row)" type="primary" size="small">查看</el-button>
          <el-popconfirm title="确定要删除这条建议吗？" @confirm="deleteClick(scope.row.id)" style="margin-left: 10px">
            <template #reference>
              <el-button type="danger" size="small">删除</el-button>
            </template>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>


    <div style="margin: 20px 0">
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page.sync="currentPage"
          :page-sizes="[5,10,20]"
          :page-size.sync="pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="totalNumber">
      </el-pagination>
    </div>

    <!--    弹出的建议是由一个弹出对话框 + 一个卡片组成的 蛮好看的还-->
    <el-dialog :title=this.advice.title :visible.sync="dialogVisible" width="50%">
      <el-card>
        <div v-html=this.advice.content  style="min-height: 100px"></div>
      </el-card>
    </el-dialog>

  </div>
</template>

<script>
// @ is an alias to /src
import request from "@/utils/request";

export default {
  name: 'AdviceView',
  components: {},

  data() {
    return {
      loading: true,
      // 查看建议框
      dialogVisible: false,
      // 总数据数
      totalNumber: 400,
      // 当前页码
      currentPage: 1,
      // 一页多少个
      pageSize: 10,
      // 输入框的数据
      search: '',
      // 表格的数据
      tableData: [],
      // 显示的建议
      advice:{},
    }
  },

  created() {
    document.title = '查看建议';
    this.loadData();
  },
  methods: {
    loadData() {
      this.loading = true
      request.get("/customerServ", {
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
    // 查看对应行的建议
    handleLook(row) {
      // 将数据深拷贝过来，避免浅拷贝的修改问题
      this.advice = JSON.parse(JSON.stringify(row));
      this.dialogVisible = true;
    },
    // 删除数据
    deleteClick(id) {
      request.delete('/customerServ', {
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
  }
}
</script>
