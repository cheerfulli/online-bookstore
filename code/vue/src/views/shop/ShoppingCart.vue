<template>
  <div style="width: 900px;margin: 25px">
<!--    购物车上面部分的结算栏-->
    <div style="display: flex;margin: 20px 10px">
      <h4>购物车（全部：{{this.totalNumber}}）</h4>
      <h4 style="margin-top: 3px;margin-left: 300px;margin-right: 25px">已选商品</h4>
      <h3 style="color: #d71d3f;font-size:25px">¥:{{totalPrice}}</h3>
      <el-button round type="danger" icon="el-icon-shopping-cart-full" @click="checkout"
                 style="margin-left: 50px;font-size: 15px;width: 100px"> 结  算 </el-button>
      <el-button round type="primary" icon="el-icon-delete" @click="deleteCarts"
                 style="margin-left: 50px;font-size: 15px;width: 100px"> 删  除 </el-button>
    </div>

    <!--    表格区域-->
    <el-table
        v-loading="loading"
        :data="tableData"
        stripe border
        :default-sort = "{prop: 'createTime', order: 'descending'}"
        @selection-change="selectChange">
      <el-table-column
          type="selection" align="center"
          width="55">
      </el-table-column>

      <!--      商品预览图-->
      <el-table-column
          label="商品预览">
        <template #default="scope">
          <el-image
              style="width: 100px; height: 100px"
              :src="scope.row.cartPicture"
              :preview-src-list="[scope.row.orderPicture]">
          </el-image>
        </template>
      </el-table-column>

      <el-table-column
          prop="cartName"
          label="商品名称">
      </el-table-column>

      <el-table-column
          prop="postFee"
          label="邮费">
      </el-table-column>

      <el-table-column label="购买数量" width="160px" align="center">
        <template #default="scope">
          <el-input-number v-model="scope.row.count" :min=1></el-input-number>
        </template>
      </el-table-column>

      <el-table-column label="价格" width="120px" align="center">
        <template #default="scope">
          <h4 style="color: #d71d3f;font-size: 20px;">￥{{(scope.row.payPrice * scope.row.count).toFixed(2)}}</h4>
        </template>
      </el-table-column>

      <!-- <el-table-column
          prop="createTime"
          label="创建时间" sortable width="140px">
      </el-table-column>
      <el-table-column label="支付状态"> -->
        <!--        这里应该是使用template 和default标签把那个整个data数据取出来，然后scope就是整个数据，每一行数据就是scope.row,tableData=scope-->
        <!-- <template #default="scope">
          <span v-if="scope.row.state === 2" style="color: orange">未支付</span>
          <span v-if="scope.row.state === 1" style="color: green">已支付</span>
        </template>
      </el-table-column> -->
    </el-table>

    <!--    页码区域,在Vue2里面是不支持v-model:prop="data"的，所以我们要用v-bind:prop.sync="data"实现双向绑定-->
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
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "ShoppingCart",
  created() {
    document.title = "我的购物车";
    // 取出当前用户信息
    // 取出session的字符串,为了防止取到空值，||一个空对象
    let str = sessionStorage.getItem("user") || "{}";
    // 赋值
    this.user = JSON.parse(str);
    // 加载数据
    this.loadData();
  },
  data() {
    return {
      // 用户选中的商品添加到购物车,是一个数组
      cart: [],
      // 表示表格正在加载
      loading: true,
      // 商品总价格
      totalPrice: 0,
      // 取出的用户信息
      user: {},
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
  },
  methods: {
    // 加载表格数据,Get请求，Get请求不能直接传对象，只有Post可以直接传对象进去
    loadData() {
      this.loading = true;
      request.get("/cart/getCarts", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          search: this.search,
          // state: 2,
        }
      }).then(res => {
        this.tableData = res.data.records;
        this.totalNumber = res.data.total;
        this.loading = false;
      })

      // /order/user_order
    },
    // 表单每页大小的改变，因为有了双向绑定，直接更新一下数据就好了
    handleSizeChange() {
      this.loadData();
    },
    // 改变当前页码
    handleCurrentChange: function () {
      this.loadData();
    },
    // 选择商品，计算价格
    selectChange(val){
      this.cart = val;
      // console.log("现在的购物车: ");
      // console.log(this.cart);
      // 每次选择商品之后重新计算价格
      if (this.cart){
        this.totalPrice = 0;
        this.cart.forEach(item => {
          this.totalPrice += item.payPrice * item.count;
        })
        this.totalPrice = this.totalPrice.toFixed(2);
      }
    },
    // 结账
    checkout(){
      // 直接将前端购物车里面的每个商品订单回传回去
      if (this.cart.length > 0){
        request.post("/cart/buyCart", this.cart, {
          params: {
            totalPrice: this.totalPrice,
            // todo 在Web端实现地址选择
            addressId: 4
          }
        }).then(res => {
          alert("即将进入支付页面，请注意支付环境安全");
          window.open(res.data);
        })
      }else {
        this.$message.error("您没有添加任何商品~");
      }
    },
    deleteCarts(){
        request.post("/cart/deleteCarts", this.cart).then(res=>{
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
      })
      // 更新数据
      this.loadData();
    }

  },
}
</script>

<style scoped>

</style>