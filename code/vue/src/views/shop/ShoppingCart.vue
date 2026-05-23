<template>
  <div class="cart-page">
    <!-- 页面标题 -->
    <div class="page-header">
      <h2><i class="el-icon-shopping-cart-2"></i> 我的购物车</h2>
      <span class="item-count">共 {{ totalNumber }} 件商品</span>
    </div>

    <!-- 结算栏 -->
    <div class="cart-summary">
      <div class="summary-left">
        <span class="selected-info">
          已选 <strong>{{ cart.length }}</strong> 件商品
        </span>
      </div>
      <div class="summary-right">
        <div class="total-price">
          <span class="label">合计：</span>
          <span class="price">¥{{ totalPrice }}</span>
        </div>
        <el-button class="btn-delete" @click="deleteCarts" :disabled="cart.length === 0">
          <i class="el-icon-delete"></i> 删除
        </el-button>
        <el-button class="btn-checkout" type="primary" @click="checkout" :disabled="cart.length === 0">
          <i class="el-icon-shopping-bag-1"></i> 结算
        </el-button>
      </div>
    </div>

    <!-- 表格区域 -->
    <div class="cart-table">
      <el-table
        v-loading="loading"
        :data="tableData"
        @selection-change="selectChange"
        :header-cell-style="{ background: '#fafafa', color: '#333', fontWeight: '600' }"
      >
        <el-table-column type="selection" width="55" align="center"></el-table-column>

        <el-table-column label="商品信息" min-width="300">
          <template #default="scope">
            <div class="product-info">
              <el-image
                class="product-image"
                :src="scope.row.cartPicture"
                :preview-src-list="[scope.row.cartPicture]"
                fit="cover"
              ></el-image>
              <div class="product-detail">
                <p class="product-name">{{ scope.row.cartName }}</p>
                <p class="product-shipping">
                  <i class="el-icon-truck"></i>
                  邮费：{{ scope.row.postFee > 0 ? '¥' + scope.row.postFee : '包邮' }}
                </p>
              </div>
            </div>
          </template>
        </el-table-column>

        <el-table-column label="单价" width="120" align="center">
          <template #default="scope">
            <span class="unit-price">¥{{ scope.row.payPrice }}</span>
          </template>
        </el-table-column>

        <el-table-column label="数量" width="150" align="center">
          <template #default="scope">
            <el-input-number
              v-model="scope.row.count"
              :min="1"
              size="small"
              @change="selectChange(cart)"
            ></el-input-number>
          </template>
        </el-table-column>

        <el-table-column label="小计" width="120" align="center">
          <template #default="scope">
            <span class="subtotal">¥{{ (scope.row.payPrice * scope.row.count).toFixed(2) }}</span>
          </template>
        </el-table-column>
      </el-table>

      <!-- 空状态 -->
      <div v-if="!loading && tableData.length === 0" class="empty-cart">
        <i class="el-icon-shopping-cart-1"></i>
        <p>购物车空空如也</p>
        <el-button type="primary" size="small" @click="$router.push('/shop')">去逛逛</el-button>
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
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "ShoppingCart",
  created() {
    document.title = "我的购物车 - TJU网上书店";
    let str = sessionStorage.getItem("user") || "{}";
    this.user = JSON.parse(str);
    this.loadData();
  },
  data() {
    return {
      cart: [],
      loading: true,
      totalPrice: 0,
      user: {},
      totalNumber: 0,
      currentPage: 1,
      pageSize: 10,
      search: '',
      tableData: []
    }
  },
  methods: {
    loadData() {
      this.loading = true;
      request.get("/cart/getCarts", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          search: this.search,
        }
      }).then(res => {
        this.tableData = res.data.records;
        this.totalNumber = res.data.total;
        this.loading = false;
      })
    },
    handleSizeChange() {
      this.loadData();
    },
    handleCurrentChange() {
      this.loadData();
    },
    selectChange(val) {
      this.cart = val;
      if (this.cart) {
        this.totalPrice = 0;
        this.cart.forEach(item => {
          this.totalPrice += item.payPrice * item.count;
        })
        this.totalPrice = this.totalPrice.toFixed(2);
      }
    },
    checkout() {
      if (this.cart.length > 0) {
        this.$confirm('确认结算选中的商品吗？', '结算确认', {
          confirmButtonText: '确认结算',
          cancelButtonText: '取消',
          type: 'info'
        }).then(() => {
          request.post("/cart/buyCart", this.cart, {
            params: {
              totalPrice: this.totalPrice,
              addressId: 4
            }
          }).then(res => {
            this.$message.success("即将进入支付页面");
            window.open(res.data);
          })
        });
      } else {
        this.$message.warning("请先选择要结算的商品");
      }
    },
    deleteCarts() {
      if (this.cart.length === 0) {
        this.$message.warning("请先选择要删除的商品");
        return;
      }
      this.$confirm('确定删除选中的商品吗？', '删除确认', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        request.post("/cart/deleteCarts", this.cart).then(res => {
          if (res.code === '0') {
            this.$message.success("删除成功");
            this.loadData();
          } else {
            this.$message.error(res.msg);
          }
        })
      });
    }
  },
}
</script>

<style scoped>
.cart-page {
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

.item-count {
  font-size: 14px;
  color: var(--text-secondary, #666);
}

/* 结算栏 */
.cart-summary {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
  background: linear-gradient(135deg, #fff9f5 0%, #fff 100%);
  border-radius: var(--radius-md, 8px);
  margin-bottom: 20px;
  box-shadow: var(--shadow-sm, 0 1px 2px rgba(0,0,0,0.06));
}

.summary-left .selected-info {
  font-size: 14px;
  color: var(--text-secondary, #666);
}

.summary-left .selected-info strong {
  color: var(--primary-color, #ff5000);
  font-size: 16px;
  margin: 0 4px;
}

.summary-right {
  display: flex;
  align-items: center;
  gap: 16px;
}

.total-price {
  display: flex;
  align-items: baseline;
  gap: 4px;
}

.total-price .label {
  font-size: 14px;
  color: var(--text-secondary, #666);
}

.total-price .price {
  font-size: 26px;
  font-weight: 700;
  color: var(--primary-color, #ff5000);
  font-family: "DIN Alternate", "Helvetica Neue", Arial, sans-serif;
}

.btn-delete {
  padding: 10px 20px;
  border-radius: var(--radius-md, 8px);
}

.btn-checkout {
  padding: 10px 28px;
  border-radius: var(--radius-md, 8px);
  background: linear-gradient(135deg, #ff5000 0%, #ff7433 100%);
  border: none;
  font-size: 15px;
}

.btn-checkout:hover {
  background: linear-gradient(135deg, #e64500 0%, #ff5000 100%);
}

/* 表格 */
.cart-table {
  background: #fff;
  border-radius: var(--radius-md, 8px);
  overflow: hidden;
}

.cart-table >>> .el-table {
  border-radius: var(--radius-md, 8px);
}

.product-info {
  display: flex;
  align-items: center;
  gap: 16px;
}

.product-image {
  width: 80px;
  height: 80px;
  border-radius: var(--radius-sm, 4px);
  overflow: hidden;
  flex-shrink: 0;
}

.product-detail {
  flex: 1;
}

.product-name {
  font-size: 14px;
  color: var(--text-primary, #333);
  margin: 0 0 8px 0;
  line-height: 1.4;
}

.product-shipping {
  font-size: 12px;
  color: var(--text-placeholder, #999);
  margin: 0;
  display: flex;
  align-items: center;
  gap: 4px;
}

.unit-price {
  font-size: 14px;
  color: var(--text-secondary, #666);
  font-family: "DIN Alternate", "Helvetica Neue", Arial, sans-serif;
}

.subtotal {
  font-size: 16px;
  font-weight: 600;
  color: var(--primary-color, #ff5000);
  font-family: "DIN Alternate", "Helvetica Neue", Arial, sans-serif;
}

/* 空状态 */
.empty-cart {
  text-align: center;
  padding: 60px 0;
  color: var(--text-placeholder, #999);
}

.empty-cart i {
  font-size: 64px;
  margin-bottom: 16px;
  color: #ddd;
}

.empty-cart p {
  font-size: 14px;
  margin: 0 0 20px 0;
}

/* 分页 */
.pagination-wrapper {
  margin-top: 20px;
  display: flex;
  justify-content: flex-end;
}
</style>
