<template>
  <div style="padding: 10px">
    <div style="margin: 10px 0;">
      <!--    功能区域-->
      <!-- <el-button type="success" round>导入</el-button>
      <el-button type="success" round>导出</el-button> -->
      <!--    搜索区域-->
      <el-button type="primary" icon="el-icon-search" style="margin-outside: 10px; float: right" @click="goSearch">搜索</el-button>
      <el-input v-model="search" placeholder="请输入搜索的用户名" style="width: 20%; float: right" clearable></el-input>
    </div>

    <!--    表格区域-->
    <el-table
        v-loading="loading"
        :data="tableData"
        stripe border
        style="width: 100%">
      <el-table-column width="100px"
          prop="id"
          label="订单ID"
          sortable>
      </el-table-column>

      <el-table-column width="120px"
                       label="商品预览图">
        <template #default="scope">
          <el-image
              style="width: 90px; height: 90px"
              :src="scope.row.orderPicture"
              :preview-src-list="[scope.row.orderPicture]">
          </el-image>
        </template>
      </el-table-column>

      <el-table-column
          prop="orderNo"
          label="订单编号" show-overflow-tooltip>
      </el-table-column>

      <el-table-column label="退款金额" align="center">
        <template #default="scope">
          <h2 style="color: red">￥{{scope.row.refundAmount}}</h2>
        </template>
      </el-table-column>

      <el-table-column width="130px"
          prop="refundReason"
          label="退款原因">
      </el-table-column>

      <el-table-column
          prop="refundDate" sortable
          label="退款时间" width="150px">
      </el-table-column>

      <el-table-column label="退款形式">
        <!--        这里应该是使用template 和default标签把那个整个data数据取出来，然后scope就是整个数据，每一行数据就是scope.row,tableData=scope-->
        <template #default="scope">
          <span v-if="scope.row.refundType === 2" style="color: orange">退货退款</span>
          <span v-if="scope.row.refundType === 1" style="color: #47bdb2">未发货退款</span>
        </template>
      </el-table-column>

      <el-table-column
          prop="username"
          label="退款人">
      </el-table-column>

      <!--     操作区域-->
      <el-table-column fixed="right" label="操作" align = "center" width="150px">
        <template #default="scope">
          <!--          这里scope.row传入直接是传入一行的数据对象，可以使用row.username取出用户名的-->
          <el-button v-on:click="editeClick(scope.row)" type="primary" size="small">详情</el-button>
          <el-popconfirm title="确定要删除这个退款项吗？" @confirm="deleteClick(scope.row.id)" style="margin-left: 10px">
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

      <!--      查看退款原因-->
      <el-dialog title="退款详情" :visible.sync="vis" width="55%">
        <el-card>
          <div v-html="refundDesc" style="min-height: 100px"></div>
        </el-card>
      </el-dialog>

    </div>
  </div>
</template>

<script>
// @ is an alias to /src
import request from "@/utils/request";

export default {
  name: 'RefundOrderView',
  created() {
    document.title = '退款订单';
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
      request.get("/refund", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          search: this.search
        }
      }).then(res => {
        console.log(res,"加载的结果");
        this.tableData = res.data.records;
        this.totalNumber = res.data.total;
        this.loading = false;
      })
    },
    // 查看退款详情
    editeClick(row) {
      this.refundDesc = row.refundDesc;
      this.vis = true;
    },
    // 删除退款订单
    deleteClick(id) {
      request.delete('/refund/'+id).then(res=>{
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
  },
  data() {
    return {
      // 表示表格正在加载
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
      pageSize: 10,
      // 输入框的数据
      search: '',
      // 表格的数据
      tableData: [],
      // 管理退款详情框
      vis: false,
      // 退款详情
      refundDesc: ""
    }
  }
}
</script>
<style scoped>
</style>