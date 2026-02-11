<template>
  <div style="width: 1000px;margin: 25px">
    <div style="display: flex;margin: 20px">
      <!--    搜索区域-->
      <el-input v-model="search" placeholder="请输入你要搜索的商品名称"
                style="width: 30%;margin-left: 250px;margin-right: 20px" clearable></el-input>
      <el-button type="primary" icon="el-icon-search" @click="goSearch">搜索</el-button>
    </div>

    <!--    表格区域-->
    <el-table
        v-loading="loading"
        :data="tableData"
        stripe border
        :default-sort="{prop: 'createTime', order: 'descending'}">

      <!--      商品预览图-->
      <el-table-column
          label="商品预览" width="130px">
        <template #default="scope">
          <el-image
              style="width: 100px; height: 100px"
              :src="scope.row.orderPicture"
              :preview-src-list="[scope.row.orderPicture]">
          </el-image>
        </template>
      </el-table-column>

      <el-table-column
          prop="orderName"
          label="商品名称">
      </el-table-column>
      <el-table-column
          prop="count"
          label="购买数量">
      </el-table-column>
      <el-table-column label="总价">
        <template #default="scope">
          <h3 style="color: #d71d3f">￥{{ (scope.row.payPrice * scope.row.count).toFixed(1) }}</h3>
        </template>
      </el-table-column>
      <el-table-column
          prop="createTime"
          label="创建时间" sortable width="140px">
      </el-table-column>
      <el-table-column
          prop="paymentTime"
          label="支付时间" sortable width="140px">
      </el-table-column>
      <el-table-column label="支付状态">
        <!--        这里应该是使用template 和default标签把那个整个data数据取出来，然后scope就是整个数据，每一行数据就是scope.row,tableData=scope-->
        <template #default="scope">
          <span v-if="scope.row.state === 2" style="color: orange">未支付</span>
          <span v-if="scope.row.state === 1" style="color: green">已支付</span>
          <span v-if="scope.row.state === 3" style="color: #b91313">已退款</span>
          <span v-if="scope.row.state === 4" style="color: blue">已发货</span>
          <span v-if="scope.row.state === 5" style="color: purple">已收货</span>
        </template>
      </el-table-column>
      <!--      操作栏-->
      <el-table-column fixed="right" label="操作" align="center" width="250px">
        <template #default="scope">
          <!--          这里scope.row传入直接是传入一行的数据对象，可以使用row.username取出用户名的-->
          <el-button type="warning" size="small" @click="refund(scope.row)">退款</el-button>
          <el-popconfirm
              title="确定要删除这个订单吗？"
              @confirm="deleteClick(scope.row.id)"
              icon-color="red"
              style="margin-left: 10px">
            <template #reference>
              <el-button type="danger" size="small">删除</el-button>
            </template>
          </el-popconfirm>
          <el-button  v-if="scope.row.state === 4" v-on:click="receiveClick(scope.row.id)" type="success" size="small" style="margin-left: 10px;">收货</el-button>
          <el-button  v-if="scope.row.state !== 4" type="info" size="small" style="margin-left: 10px;">收货</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!--    页码区域和弹出退款框，在Vue2里面是不支持v-model:prop="data"的，所以我们要用v-bind:prop.sync="data"实现双向绑定-->
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

      <!--      退款的表单-->
      <el-dialog title="申请退款" :visible.sync="dialogVisible" width="50%">
        <el-form label-width="100px" class="demo-ruleForm">
          <el-form-item label="商品信息">
            <h3>{{refundForm.orderName}}</h3>
          </el-form-item>
          <el-form-item label="申请类型">
            <el-radio-group v-model="refundForm.refundType">
              <el-radio label="1">我要退款（还未发货）</el-radio>
              <el-radio label="2">我要退货退款</el-radio>
            </el-radio-group>
          </el-form-item>
          <el-form-item label="申请原因">
            <el-select v-model="refundForm.refundReason" placeholder="请选择退款原因">
              <el-option
                  v-for="item in options"
                  :key="item.label"
                  :label="item.label"
                  :value="item.label"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="申请金额">
            <h1 style="color: #d01f40">￥{{refundForm.payPrice * refundForm.count}} (默认全额退款）</h1>
          </el-form-item>
          <el-form-item label="申请说明">
            <el-input type="textarea"
                      maxlength="170" show-word-limit
                      v-model="refundForm.refundDesc"
                      style="width: 70%;font-size: 15px">
            </el-input>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="submitRefund()">立即退款</el-button>
            <el-button @click="dialogVisible = false">取消</el-button>
          </el-form-item>
        </el-form>
      </el-dialog>
    </div>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "MyOrder",
  created() {
    document.title = "我的订单";
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
      // 表示表格正在加载
      loading: true,
      // 取出的用户信息
      user: {},
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
      // 申请退款框
      dialogVisible: false,
      // 退款相关
      refundForm:{},
      options: [{
        value: '选项1',
        label: '七天无理由退换'
      }, {
        value: '选项2',
        label: '与商家协调一致退款'
      }, {
        value: '选项3',
        label: '商品与商品描述不符'
      }, {
        value: '选项4',
        label: '不喜欢，效果不好'
      }, {
        value: '选项5',
        label: '质量问题'
      }, {
        value: '选项6',
        label: '收到商品少件'
      }, {
        value: '选项7',
        label: '商品破损或污渍'
      }, {
        value: '选项8',
        label: '空包裹'
      }, {
        value: '选项9',
        label: '商家发错货'
      }, {
        value: '选项10',
        label: '假冒品牌'
      }, {
        value: '选项11',
        label: '其他原因'
      }],
    }
  },
  methods: {
    // 提交退款
    submitRefund(){
      console.log(this.refundForm,"当前退款的表格");
      // 开始判断表格的信息是否填写完整
      if (this.refundForm.refundType == null || this.refundForm.refundType.length === 0)
        this.$message.warning("请选择申请类型")
      else if (this.refundForm.refundReason == null || this.refundForm.refundReason.length === 0)
        this.$message.warning("请填写申请原因")
      else if (this.refundForm.refundDesc == null || this.refundForm.refundDesc.length === 0)
        this.$message.warning("请填写申请说明")
      // 填写完成开始退款
      else {
        this.$message.success("已发送申请")
        request.post("/alipay/refund",this.refundForm).then(res => {
          if (res.code === '0'){
            this.$message({
              type: "success",
              message: "退款成功"
            })
            location.reload();
          }else {
            this.$message({
              type: "error",
              message: res.msg
            })
          }
        })
      }
    },

    // 退款功能
    refund(order) {
      if (order.state !== 1) {
        this.$message.error("已支付的订单才可以退款哦~~~");
        return
      }
      console.log(order, "点击的退款订单");
      // 先清空上个信息
      this.refundForm = {};
      // 再把这个商品的信息传入
      this.refundForm = order;
      // 计算退款金额
      this.refundForm.refundAmount = this.refundForm.payPrice * this.refundForm.count;
      // 先显示选择退款原因
      this.dialogVisible = true;
    },

    // 搜索功能
    goSearch: function () {
      this.loadData();
    },
    // 加载表格数据,Get 请求，Get 请求不能直接传对象，只有 Post 可以直接传对象进去
    loadData() {
      this.loading = true;
      request.get("/order/user_order", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          search: this.search
        }
      }).then(res => {
        this.tableData = res.data.records;
        this.totalNumber = res.data.total;
        this.loading = false;
      })
    },
    // 删除数据
    deleteClick(id) {
      request.delete('/order/' + id).then(res => {
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
      this.loadData();
    },
    receiveClick(id) {
      request.put('/order/receive/'+id).then(res=>{
        if (res.code === '0') {
          this.$message({
            type: "warning",
            message: "收货成功",
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
}
</script>

<style scoped>

</style>