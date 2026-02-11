<template>
  <div style="padding: 10px">
    <div style="margin: 10px 0;">
      <!--    功能区域-->
      <el-button type="primary" round v-on:click="add">新增</el-button>
      <!-- <el-button type="success" round>导入</el-button>
      <el-button type="success" round>导出</el-button> -->
      <!--    搜索区域-->
      <el-button type="primary" icon="el-icon-search" style="margin-outside: 10px; float: right" @click="goSearch">搜索</el-button>
      <el-input v-model="search" placeholder="请输入你搜索的订单名称" style="width: 20%; float: right" clearable></el-input>
    </div>

    <!--    表格区域-->
    <el-table
        v-loading="loading"
        :data="tableData"
        stripe border
        style="width: 100%">
      <el-table-column
          prop="id"
          label="订单ID"
          width="80px"
          sortable>
      </el-table-column>
      <el-table-column
          prop="orderName"
          label="商品名称">
      </el-table-column>
      <el-table-column
          prop="orderNo"
          label="订单编号" show-overflow-tooltip>
      </el-table-column>
      <el-table-column label="总价">
        <template #default="scope">
          <h3 style="color: #d71d3f">￥{{ (scope.row.payPrice * scope.row.count).toFixed(1) }}</h3>
        </template>
      </el-table-column>
      <el-table-column
          prop="postFee"
          label="邮费">
      </el-table-column>
      <el-table-column
          prop="createTime" sortable
          label="创建时间" width="150px">
      </el-table-column>
      <el-table-column
          prop="paymentTime" sortable
          label="支付时间" width="150px">
      </el-table-column>
      <el-table-column label="支付状态" width="80px">
        <!--        这里应该是使用template 和default标签把那个整个data数据取出来，然后scope就是整个数据，每一行数据就是scope.row,tableData=scope-->
        <template #default="scope">
          <span v-if="scope.row.state === 2" style="color: orange">未支付</span>
          <span v-if="scope.row.state === 1" style="color: green">已支付</span>
          <span v-if="scope.row.state === 3" style="color: #b91313">已退款</span>
          <span v-if="scope.row.state === 4" style="color: blue">已发货</span>
          <span v-if="scope.row.state === 5" style="color: purple">已收货</span>
        </template>
      </el-table-column>
      <el-table-column
          prop="username"
          label="购买人">
      </el-table-column>
      <!--     操作区域-->
      <el-table-column fixed="right" label="操作" align = "center" width="250px">
        <template #default="scope">
          <!--          这里scope.row传入直接是传入一行的数据对象，可以使用row.username取出用户名的-->
          <el-button v-on:click="editeClick(scope.row)" type="primary" size="small">编辑</el-button>
          <el-popconfirm title="确定要删除这个订单吗？" @confirm="deleteClick(scope.row.id)" style="margin-left: 10px">
            <template #reference>
            <el-button type="danger" size="small">删除</el-button>
            </template>
          </el-popconfirm>
          <el-button  v-if="scope.row.state === 1" v-on:click="sendClick(scope.row.id)" type="success" size="small" style="margin-left: 10px;">发货</el-button>
          <el-button  v-if="scope.row.state !== 1" type="info" size="small" style="margin-left: 10px;">发货</el-button>
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

      <!--      添加商品的表单，不加sync子组件里面的值改变，就传不到父组件里面去了-->
      <el-dialog title="新增/修改订单" :visible.sync="dialogVisible" width="40%">
        <!--        输入表单-->
        <el-form v-bind:model="form" label-width="120px">
          <el-form-item label="商品名称：">
            <el-input v-model="form.orderName" style="width: 80%"></el-input>
          </el-form-item>
          <el-form-item label="订单编号：">
            <el-input v-model="form.orderNo" style="width: 80%"></el-input>
          </el-form-item>
          <el-form-item label="单价：">
            <el-input v-model="form.payPrice" style="width: 80%"></el-input>
          </el-form-item>
          <el-form-item label="邮费：">
            <el-input v-model="form.postFee" style="width: 80%"></el-input>
          </el-form-item>
          <el-form-item label="订单状态：">
              <el-radio v-model="form.state" :label="1">已支付</el-radio>
              <el-radio v-model="form.state" :label="2">未支付</el-radio>
          </el-form-item>
          <el-form-item label="创建时间：">
            <el-date-picker
                v-model="form.createTime" type="datetime" placeholder="选择创建时间"
                value-format="yyyy-MM-dd HH:mm:ss" clearable>
            </el-date-picker>
          </el-form-item>
          <el-form-item label="支付时间：">
            <el-date-picker
                v-model="form.paymentTime" type="datetime" placeholder="选择支付时间"
                value-format="yyyy-MM-dd HH:mm:ss" clearable>
            </el-date-picker>
          </el-form-item>
          <el-form-item label="购买人：">
            <el-input v-model="form.username" style="width: 80%"></el-input>
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
  name: 'OrderView',
  created() {
    document.title = '订单管理';
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
      request.get("/order", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          search: this.search
        }
      }).then(res => {
        console.log("加载数据的结果"+res);
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
        request.put("/order",this.form).then(res =>{
          console.log("更新的结果"+res);
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
        request.post("/order", this.form).then(res => {
          console.log("新增的结果"+res);
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
      // 传入的是对象，要通过stringify换成字符串才能识别
      // 将数据深拷贝过来，避免浅拷贝的修改问题
      this.form = JSON.parse(JSON.stringify(row));
      this.dialogVisible = true;
    },
    // 删除数据
    deleteClick(id) {
      request.delete('/order/'+id).then(res=>{
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
    sendClick(id) {
      request.put('/order/send/'+id).then(res=>{
        if (res.code === '0') {
          this.$message({
            type: "warning",
            message: "发货成功",
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
      tableData: []
    }
  }
}
</script>
<style scoped>
</style>