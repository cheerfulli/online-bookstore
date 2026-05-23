<template>
  <div class="order-page">
    <!-- 页面标题 -->
    <div class="page-header">
      <h2><i class="el-icon-document"></i> 我的订单</h2>
      <span class="order-count">共 {{ totalNumber }} 条订单</span>
    </div>

    <!-- 搜索区域 -->
    <div class="search-bar">
      <el-input
        v-model="search"
        placeholder="搜索商品名称..."
        clearable
        class="search-input"
        @keydown.enter.native="goSearch"
      >
        <template #prefix>
          <i class="el-icon-search"></i>
        </template>
      </el-input>
      <el-button type="primary" @click="goSearch">
        <i class="el-icon-search"></i> 搜索
      </el-button>
    </div>

    <!-- 表格区域 -->
    <div class="order-table">
      <el-table
        v-loading="loading"
        :data="tableData"
        :default-sort="{ prop: 'createTime', order: 'descending' }"
        :header-cell-style="{ background: '#fafafa', color: '#333', fontWeight: '600' }"
        @sort-change="handleSortChange"
      >
        <!-- 商品预览图 -->
        <el-table-column label="商品信息" min-width="280">
          <template #default="scope">
            <div class="product-info">
              <el-image
                class="product-image"
                :src="scope.row.orderPicture"
                :preview-src-list="[scope.row.orderPicture]"
                fit="cover"
              ></el-image>
              <div class="product-detail">
                <p class="product-name">{{ scope.row.orderName }}</p>
                <p class="product-count">x{{ scope.row.count }}</p>
              </div>
            </div>
          </template>
        </el-table-column>

        <el-table-column label="总价" width="120" align="center">
          <template #default="scope">
            <span class="price-medium">¥{{ (scope.row.payPrice * scope.row.count).toFixed(2) }}</span>
          </template>
        </el-table-column>

        <el-table-column prop="createTime" label="创建时间" sortable="custom" width="160" align="center">
        </el-table-column>

        <el-table-column prop="paymentTime" label="支付时间" sortable="custom" width="160" align="center">
        </el-table-column>

        <el-table-column label="状态" width="100" align="center">
          <template #default="scope">
            <span v-if="scope.row.state === 1" class="status-tag status-tag--success">已支付</span>
            <span v-else-if="scope.row.state === 2" class="status-tag status-tag--warning">未支付</span>
            <span v-else-if="scope.row.state === 3" class="status-tag status-tag--danger">已退款</span>
            <span v-else-if="scope.row.state === 4" class="status-tag status-tag--info">已发货</span>
            <span v-else-if="scope.row.state === 5" class="status-tag status-tag--purple">已收货</span>
          </template>
        </el-table-column>

        <!-- 操作栏 -->
        <el-table-column fixed="right" label="操作" align="center" width="160">
          <template #default="scope">
            <div class="action-buttons">
              <!-- 主要操作：收货 -->
              <el-button
                v-if="scope.row.state === 4"
                type="success"
                size="mini"
                @click="receiveClick(scope.row.id)"
              >
                <i class="el-icon-check"></i> 收货
              </el-button>
              <el-button v-else type="info" size="mini" disabled plain>
                <i class="el-icon-check"></i> 收货
              </el-button>

              <!-- 更多操作下拉菜单 -->
              <el-dropdown trigger="click" @command="handleCommand($event, scope.row)">
                <el-button size="mini" plain>
                  更多 <i class="el-icon-arrow-down el-icon--right"></i>
                </el-button>
                <template #dropdown>
                  <el-dropdown-menu>
                    <el-dropdown-item
                      command="refund"
                      :disabled="scope.row.state !== 1"
                      icon="el-icon-refresh-left"
                    >
                      申请退款
                    </el-dropdown-item>
                    <el-dropdown-item
                      command="delete"
                      icon="el-icon-delete"
                      divided
                    >
                      <span class="danger-text">删除订单</span>
                    </el-dropdown-item>
                  </el-dropdown-menu>
                </template>
              </el-dropdown>
            </div>
          </template>
        </el-table-column>
      </el-table>

      <!-- 空状态 -->
      <div v-if="!loading && tableData.length === 0" class="empty-state">
        <i class="el-icon-document"></i>
        <p>暂无订单记录</p>
        <el-button type="primary" size="small" @click="$router.push('/shop')">去购物</el-button>
      </div>
    </div>

    <!-- 分页 -->
    <div class="pagination-wrapper" v-if="totalNumber > 0">
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

    <!-- 退款弹窗 -->
    <el-dialog title="申请退款" :visible.sync="dialogVisible" width="500px" class="refund-dialog">
      <el-form label-width="90px" class="refund-form">
        <el-form-item label="商品信息">
          <div class="refund-product">{{ refundForm.orderName }}</div>
        </el-form-item>
        <el-form-item label="申请类型">
          <el-radio-group v-model="refundForm.refundType">
            <el-radio label="1">我要退款（还未发货）</el-radio>
            <el-radio label="2">我要退货退款</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="申请原因">
          <el-select v-model="refundForm.refundReason" placeholder="请选择退款原因" style="width: 100%">
            <el-option
              v-for="item in options"
              :key="item.label"
              :label="item.label"
              :value="item.label"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="退款金额">
          <div class="refund-amount">
            <span class="price-large">¥{{ refundForm.payPrice * refundForm.count }}</span>
            <span class="refund-tip">（默认全额退款）</span>
          </div>
        </el-form-item>
        <el-form-item label="申请说明">
          <el-input
            type="textarea"
            :rows="3"
            maxlength="170"
            show-word-limit
            v-model="refundForm.refundDesc"
            placeholder="请描述退款原因..."
          ></el-input>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitRefund">提交申请</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "MyOrder",
  created() {
    document.title = "我的订单 - TJU网上书店";
    let str = sessionStorage.getItem("user") || "{}";
    this.user = JSON.parse(str);
    this.loadData();
  },
  data() {
    return {
      loading: true,
      user: {},
      totalNumber: 0,
      currentPage: 1,
      pageSize: 5,
      search: '',
      sortField: 'createTime',
      sortOrder: 'desc',
      tableData: [],
      dialogVisible: false,
      refundForm: {},
      options: [
        { value: '选项1', label: '七天无理由退换' },
        { value: '选项2', label: '与商家协调一致退款' },
        { value: '选项3', label: '商品与商品描述不符' },
        { value: '选项4', label: '不喜欢，效果不好' },
        { value: '选项5', label: '质量问题' },
        { value: '选项6', label: '收到商品少件' },
        { value: '选项7', label: '商品破损或污渍' },
        { value: '选项8', label: '空包裹' },
        { value: '选项9', label: '商家发错货' },
        { value: '选项10', label: '假冒品牌' },
        { value: '选项11', label: '其他原因' }
      ],
    }
  },
  methods: {
    handleCommand(command, row) {
      if (command === 'refund') {
        this.refund(row);
      } else if (command === 'delete') {
        this.$confirm('确定要删除这个订单吗？', '删除确认', {
          confirmButtonText: '确定删除',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.deleteClick(row.id);
        }).catch(() => {});
      }
    },
    submitRefund() {
      if (!this.refundForm.refundType) {
        this.$message.warning("请选择申请类型");
        return;
      }
      if (!this.refundForm.refundReason) {
        this.$message.warning("请选择申请原因");
        return;
      }
      if (!this.refundForm.refundDesc) {
        this.$message.warning("请填写申请说明");
        return;
      }
      this.$message.success("已发送申请");
      request.post("/alipay/refund", this.refundForm).then(res => {
        if (res.code === '0') {
          this.$message.success("退款成功");
          this.dialogVisible = false;
          this.loadData();
        } else {
          this.$message.error(res.msg);
        }
      });
    },
    refund(order) {
      if (order.state !== 1) {
        this.$message.warning("仅已支付的订单可以申请退款");
        return;
      }
      this.refundForm = { ...order };
      this.refundForm.refundAmount = this.refundForm.payPrice * this.refundForm.count;
      this.dialogVisible = true;
    },
    goSearch() {
      this.currentPage = 1;
      this.loadData();
    },
    loadData() {
      this.loading = true;
      request.get("/order/user_order", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          search: this.search,
          sortField: this.sortField,
          sortOrder: this.sortOrder
        }
      }).then(res => {
        this.tableData = res.data.records;
        this.totalNumber = res.data.total;
        this.loading = false;
      });
    },
    deleteClick(id) {
      request.delete('/order/' + id).then(res => {
        if (res.code === '0') {
          this.$message.success("删除成功");
          this.loadData();
        } else {
          this.$message.error(res.msg);
        }
      });
    },
    receiveClick(id) {
      request.put('/order/receive/' + id).then(res => {
        if (res.code === '0') {
          this.$message.success("收货成功");
          this.loadData();
        } else {
          this.$message.error(res.msg);
        }
      });
    },
    handleSizeChange() {
      this.loadData();
    },
    handleCurrentChange() {
      this.loadData();
    },
    handleSortChange({ prop, order }) {
      if (prop && order) {
        this.sortField = prop;
        this.sortOrder = order === 'ascending' ? 'asc' : 'desc';
      } else {
        this.sortField = 'createTime';
        this.sortOrder = 'desc';
      }
      this.currentPage = 1;
      this.loadData();
    }
  },
}
</script>

<style scoped>
.order-page {
  padding: 24px;
}

/* 页面标题 */
.page-header {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 20px;
  padding-bottom: 16px;
  border-bottom: 1px solid var(--border-color, #e8e8e8);
}

.page-header h2 {
  font-size: 20px;
  font-weight: 600;
  color: var(--text-primary, #333);
  margin: 0;
  display: flex;
  align-items: center;
  gap: 8px;
}

.page-header h2 i {
  color: var(--primary-color, #ff5000);
}

.order-count {
  font-size: 14px;
  color: var(--text-secondary, #666);
}

/* 搜索栏 */
.search-bar {
  display: flex;
  gap: 12px;
  margin-bottom: 20px;
}

.search-input {
  width: 300px;
}

.search-input >>> .el-input__inner {
  border-radius: 20px;
  padding-left: 36px;
}

/* 表格 */
.order-table {
  background: #fff;
  border-radius: var(--radius-md, 8px);
  overflow: hidden;
}

.product-info {
  display: flex;
  align-items: center;
  gap: 12px;
}

.product-image {
  width: 70px;
  height: 70px;
  border-radius: var(--radius-sm, 4px);
  overflow: hidden;
  flex-shrink: 0;
}

.product-detail {
  flex: 1;
  min-width: 0;
}

.product-name {
  font-size: 14px;
  color: var(--text-primary, #333);
  margin: 0 0 6px 0;
  line-height: 1.4;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.product-count {
  font-size: 12px;
  color: var(--text-placeholder, #999);
  margin: 0;
}

/* 价格样式 */
.price-medium {
  font-size: 18px;
  font-weight: 600;
  color: var(--primary-color, #ff5000);
  font-family: "DIN Alternate", "Helvetica Neue", Arial, sans-serif;
}

.price-large {
  font-size: 26px;
  font-weight: 700;
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

/* 操作按钮 */
.action-buttons {
  display: flex;
  gap: 8px;
  justify-content: center;
  align-items: center;
  flex-wrap: nowrap;
}

.action-buttons .el-button {
  padding: 7px 12px;
  font-size: 12px;
  border-radius: 4px;
}

.action-buttons .el-button--success {
  background: linear-gradient(135deg, #52c41a 0%, #73d13d 100%);
  border-color: #52c41a;
}

.action-buttons .el-button--success:hover {
  background: linear-gradient(135deg, #73d13d 0%, #95de64 100%);
  border-color: #73d13d;
}

/* 下拉菜单样式 */
.action-buttons >>> .el-dropdown {
  vertical-align: middle;
}

.danger-text {
  color: #f56c6c;
}

/* 空状态 */
.empty-state {
  text-align: center;
  padding: 60px 0;
  color: var(--text-placeholder, #999);
}

.empty-state i {
  font-size: 64px;
  margin-bottom: 16px;
  color: #ddd;
}

.empty-state p {
  font-size: 14px;
  margin: 0 0 20px 0;
}

/* 分页 */
.pagination-wrapper {
  margin-top: 20px;
  display: flex;
  justify-content: flex-end;
}

/* 退款弹窗 */
.refund-dialog >>> .el-dialog {
  border-radius: var(--radius-lg, 12px);
}

.refund-dialog >>> .el-dialog__header {
  border-bottom: 1px solid var(--border-color, #e8e8e8);
  padding: 16px 20px;
}

.refund-dialog >>> .el-dialog__title {
  font-size: 16px;
  font-weight: 600;
}

.refund-dialog >>> .el-dialog__body {
  padding: 24px 20px;
}

.refund-product {
  font-size: 14px;
  font-weight: 500;
  color: var(--text-primary, #333);
}

.refund-amount {
  display: flex;
  align-items: baseline;
  gap: 8px;
}

.refund-tip {
  font-size: 12px;
  color: var(--text-placeholder, #999);
}
</style>
