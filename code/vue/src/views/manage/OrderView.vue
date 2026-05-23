<template>
  <div class="manage-page">
    <!-- 操作栏 -->
    <div class="action-bar">
      <div class="action-left">
        <el-button type="primary" @click="add">
          <i class="el-icon-plus"></i> 新增订单
        </el-button>
      </div>
      <div class="action-right">
        <el-input
          v-model="search"
          placeholder="搜索订单名称..."
          clearable
          class="search-input"
          @keydown.enter.native="goSearch"
        >
          <template #prefix>
            <i class="el-icon-search"></i>
          </template>
        </el-input>
        <el-button type="primary" @click="goSearch">搜索</el-button>
      </div>
    </div>

    <!-- 表格区域 -->
    <div class="table-container">
      <el-table
        v-loading="loading"
        :data="tableData"
        stripe
        :header-cell-style="{ background: '#fafafa', color: '#333', fontWeight: '600' }"
      >
        <el-table-column prop="id" label="订单ID" width="80" sortable align="center"></el-table-column>
        <el-table-column prop="orderName" label="商品名称" min-width="150"></el-table-column>
        <el-table-column prop="orderNo" label="订单编号" show-overflow-tooltip min-width="180"></el-table-column>
        <el-table-column label="总价" width="120" align="center">
          <template #default="scope">
            <span class="price-text">¥{{ (scope.row.payPrice * scope.row.count).toFixed(2) }}</span>
          </template>
        </el-table-column>
        <el-table-column prop="postFee" label="邮费" width="80" align="center">
          <template #default="scope">
            <span>{{ scope.row.postFee > 0 ? '¥' + scope.row.postFee : '包邮' }}</span>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" sortable label="创建时间" width="160" align="center"></el-table-column>
        <el-table-column prop="paymentTime" sortable label="支付时间" width="160" align="center"></el-table-column>
        <el-table-column label="状态" width="100" align="center">
          <template #default="scope">
            <span v-if="scope.row.state === 1" class="status-tag status-tag--success">已支付</span>
            <span v-else-if="scope.row.state === 2" class="status-tag status-tag--warning">未支付</span>
            <span v-else-if="scope.row.state === 3" class="status-tag status-tag--danger">已退款</span>
            <span v-else-if="scope.row.state === 4" class="status-tag status-tag--info">已发货</span>
            <span v-else-if="scope.row.state === 5" class="status-tag status-tag--purple">已收货</span>
          </template>
        </el-table-column>
        <el-table-column prop="username" label="购买人" width="100" align="center"></el-table-column>
        <el-table-column fixed="right" label="操作" align="center" width="180">
          <template #default="scope">
            <div class="action-links">
              <el-button type="text" size="mini" @click="editeClick(scope.row)">
                编辑
              </el-button>
              <el-divider direction="vertical"></el-divider>
              <el-popconfirm title="确定要删除这个订单吗？" @confirm="deleteClick(scope.row.id)">
                <template #reference>
                  <el-button type="text" size="mini" class="danger-link">删除</el-button>
                </template>
              </el-popconfirm>
              <el-divider direction="vertical"></el-divider>
              <el-button
                type="text"
                size="mini"
                :disabled="scope.row.state !== 1"
                :class="{ 'success-link': scope.row.state === 1 }"
                @click="sendClick(scope.row.id)"
              >
                发货
              </el-button>
            </div>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <!-- 分页 -->
    <div class="pagination-wrapper">
      <el-pagination
        background
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page.sync="currentPage"
        :page-sizes="[5, 10, 20]"
        :page-size.sync="pageSize"
        layout="total, sizes, prev, pager, next, jumper"
        :total="totalNumber"
      ></el-pagination>
    </div>

    <!-- 新增/编辑弹窗 -->
    <el-dialog
      :title="form.id ? '编辑订单' : '新增订单'"
      :visible.sync="dialogVisible"
      width="500px"
      class="manage-dialog"
    >
      <el-form :model="form" label-width="100px" class="manage-form">
        <el-form-item label="商品名称">
          <el-input v-model="form.orderName" placeholder="请输入商品名称"></el-input>
        </el-form-item>
        <el-form-item label="订单编号">
          <el-input v-model="form.orderNo" placeholder="请输入订单编号"></el-input>
        </el-form-item>
        <el-form-item label="单价">
          <el-input v-model="form.payPrice" placeholder="请输入单价" type="number"></el-input>
        </el-form-item>
        <el-form-item label="邮费">
          <el-input v-model="form.postFee" placeholder="请输入邮费" type="number"></el-input>
        </el-form-item>
        <el-form-item label="订单状态">
          <el-radio-group v-model="form.state">
            <el-radio :label="1">已支付</el-radio>
            <el-radio :label="2">未支付</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="创建时间">
          <el-date-picker
            v-model="form.createTime"
            type="datetime"
            placeholder="选择创建时间"
            value-format="yyyy-MM-dd HH:mm:ss"
            clearable
            style="width: 100%"
          ></el-date-picker>
        </el-form-item>
        <el-form-item label="支付时间">
          <el-date-picker
            v-model="form.paymentTime"
            type="datetime"
            placeholder="选择支付时间"
            value-format="yyyy-MM-dd HH:mm:ss"
            clearable
            style="width: 100%"
          ></el-date-picker>
        </el-form-item>
        <el-form-item label="购买人">
          <el-input v-model="form.username" placeholder="请输入购买人"></el-input>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="save">确定</el-button>
      </template>
    </el-dialog>
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
.manage-page {
  padding: 20px;
}

/* 操作栏 */
.action-bar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  padding: 16px 20px;
  background: #fff;
  border-radius: var(--radius-md, 8px);
  box-shadow: var(--shadow-sm, 0 1px 2px rgba(0,0,0,0.06));
}

.action-right {
  display: flex;
  align-items: center;
  gap: 12px;
}

.search-input {
  width: 280px;
}

.search-input >>> .el-input__inner {
  border-radius: 20px;
  padding-left: 36px;
}

/* 表格容器 */
.table-container {
  background: #fff;
  border-radius: var(--radius-md, 8px);
  overflow: hidden;
  box-shadow: var(--shadow-sm, 0 1px 2px rgba(0,0,0,0.06));
}

/* 价格样式 */
.price-text {
  font-size: 16px;
  font-weight: 600;
  color: var(--primary-color, #ff5000);
  font-family: "DIN Alternate", "Helvetica Neue", Arial, sans-serif;
}

/* 状态标签 */
.status-tag {
  display: inline-flex;
  align-items: center;
  padding: 4px 10px;
  border-radius: 10px;
  font-size: 12px;
  font-weight: 500;
}

.status-tag--success {
  background: rgba(82, 196, 26, 0.1);
  color: #52c41a;
}

.status-tag--warning {
  background: rgba(250, 173, 20, 0.1);
  color: #faad14;
}

.status-tag--danger {
  background: rgba(245, 34, 45, 0.1);
  color: #f5222d;
}

.status-tag--info {
  background: rgba(24, 144, 255, 0.1);
  color: #1890ff;
}

.status-tag--purple {
  background: rgba(114, 46, 209, 0.1);
  color: #722ed1;
}

/* 表格操作按钮 */
.table-actions {
  display: flex;
  gap: 8px;
  justify-content: center;
  flex-wrap: nowrap;
}

.table-actions .el-button {
  padding: 5px 10px;
  font-size: 12px;
}

/* 文字链接操作按钮 */
.action-links {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 0;
  white-space: nowrap;
}

.action-links .el-button--text {
  padding: 4px 8px;
  font-size: 13px;
  color: var(--primary-color, #ff5000);
}

.action-links .el-button--text:hover {
  color: var(--primary-light, #ff7433);
}

.action-links .danger-link {
  color: #f56c6c !important;
}

.action-links .danger-link:hover {
  color: #f78989 !important;
}

.action-links .success-link {
  color: #52c41a !important;
}

.action-links .success-link:hover {
  color: #73d13d !important;
}

.action-links .el-button.is-disabled {
  color: #c0c4cc !important;
}

.action-links .el-divider--vertical {
  margin: 0 4px;
  height: 14px;
  background-color: #dcdfe6;
}

/* 分页 */
.pagination-wrapper {
  margin-top: 20px;
  display: flex;
  justify-content: flex-end;
}

/* 弹窗样式 */
.manage-dialog >>> .el-dialog {
  border-radius: var(--radius-lg, 12px);
}

.manage-dialog >>> .el-dialog__header {
  border-bottom: 1px solid var(--border-color, #e8e8e8);
  padding: 16px 20px;
}

.manage-dialog >>> .el-dialog__title {
  font-size: 16px;
  font-weight: 600;
}

.manage-dialog >>> .el-dialog__body {
  padding: 24px 20px;
}

.manage-form .el-form-item {
  margin-bottom: 18px;
}

.manage-form >>> .el-input__inner {
  border-radius: var(--radius-sm, 4px);
}
</style>