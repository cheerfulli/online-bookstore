<template>
  <div class="detail-page">
    <!-- 面包屑导航 -->
    <div class="breadcrumb">
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/shop' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>商品详情</el-breadcrumb-item>
      </el-breadcrumb>
    </div>

    <!-- 商品主体 -->
    <div class="detail-container">
      <!-- 左侧图片 -->
      <div class="product-gallery">
        <el-image
          class="main-image"
          :src="itemData.image"
          :preview-src-list="[itemData.image]"
          fit="contain"
        >
          <template #placeholder>
            <div class="image-placeholder">
              <i class="el-icon-picture-outline"></i>
            </div>
          </template>
        </el-image>
      </div>

      <!-- 右侧详情 -->
      <div class="product-detail">
        <h1 class="product-title">{{ itemData.title }}</h1>
        <p class="product-sellpoint">{{ itemData.sellPoint }}</p>

        <!-- 价格区域 -->
        <div class="price-section">
          <div class="price-row">
            <span class="label">价格</span>
            <span class="price">¥{{ itemData.price }}</span>
          </div>
          <div class="price-row">
            <span class="label">配送</span>
            <span class="value">
              <i class="el-icon-location-outline"></i>
              {{ user.address || '请设置收货地址' }}
            </span>
          </div>
        </div>

        <!-- 商品信息 -->
        <div class="info-section">
          <div class="info-row">
            <span class="label">库存</span>
            <span class="value">
              <el-tag v-if="itemData.stock > 10" type="success" size="small">有货</el-tag>
              <el-tag v-else-if="itemData.stock > 0" type="warning" size="small">仅剩 {{ itemData.stock }} 件</el-tag>
              <el-tag v-else type="info" size="small">暂时缺货</el-tag>
            </span>
          </div>
          <div class="info-row">
            <span class="label">服务</span>
            <span class="value">
              <span class="service-tag"><i class="el-icon-check"></i> 七天无理由</span>
              <span class="service-tag"><i class="el-icon-check"></i> 包邮</span>
            </span>
          </div>
          <div class="info-row">
            <span class="label">数量</span>
            <span class="value">
              <el-input-number v-model="num" :min="1" :max="itemData.stock || 99" size="medium"></el-input-number>
            </span>
          </div>
        </div>

        <!-- 操作按钮 -->
        <div class="action-section">
          <el-button class="btn-cart" size="large" @click="addCart">
            <i class="el-icon-shopping-cart-2"></i> 加入购物车
          </el-button>
          <el-button class="btn-buy" size="large" type="primary" @click="buy">
            <i class="el-icon-shopping-bag-1"></i> 立即购买
          </el-button>
        </div>
      </div>
    </div>

    <!-- 商品详情 -->
    <div class="detail-section">
      <div class="section-header">
        <h2><i class="el-icon-document"></i> 商品详情</h2>
      </div>
      <div class="section-content" v-html="proUrl"></div>
    </div>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "Detail",
  created() {
    this.loadData(this.$route.query.id);
    let str = sessionStorage.getItem("user") || "{}";
    this.user = JSON.parse(str);
  },
  data() {
    return {
      proUrl: "",
      user: {},
      itemData: {},
      num: 1,
    }
  },
  methods: {
    loadData(id) {
      request.get('/item/one', {
        params: { id: id }
      }).then(res => {
        this.itemData = res.data;
        document.title = this.itemData.title + ' - TJU网上书店';
      });

      request.get("/itemDetail", {
        params: { id: id }
      }).then(res => {
        this.proUrl = res.data.itemDetail;
      });
    },
    buy() {
      request.get("/order/buy", {
        params: {
          itemId: this.itemData.id,
          userId: this.user.id,
          count: this.num
        }
      }).then(res => {
        this.$message.success("即将进入支付页面");
        this.$confirm('即将跳转到支付页面，请注意支付环境安全', '支付确认', {
          confirmButtonText: '继续支付',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          window.open(res.data);
        });
      })
    },
    addCart() {
      this.$confirm('确定将此商品加入购物车吗？', '加入购物车', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'info'
      }).then(() => {
        request.get('/cart/add', {
          params: {
            itemId: this.itemData.id,
            userId: this.user.id,
            count: this.num
          }
        }).then(() => {
          this.$message.success("已加入购物车");
        });
      }).catch(() => {});
    }
  }
}
</script>

<style scoped>
.detail-page {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
  background-color: var(--bg-page, #f5f5f5);
  min-height: 100vh;
}

/* 面包屑 */
.breadcrumb {
  margin-bottom: 20px;
  padding: 12px 20px;
  background: #fff;
  border-radius: var(--radius-md, 8px);
}

/* 商品主体 */
.detail-container {
  display: flex;
  gap: 40px;
  padding: 30px;
  background: #fff;
  border-radius: var(--radius-lg, 12px);
  box-shadow: var(--shadow-sm, 0 1px 2px rgba(0,0,0,0.06));
}

/* 左侧图片 */
.product-gallery {
  flex-shrink: 0;
  width: 400px;
}

.main-image {
  width: 400px;
  height: 400px;
  border-radius: var(--radius-md, 8px);
  overflow: hidden;
  background: #f9f9f9;
}

.image-placeholder {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 48px;
  color: #ddd;
}

/* 右侧详情 */
.product-detail {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.product-title {
  font-size: 22px;
  font-weight: 600;
  color: var(--text-primary, #333);
  margin: 0 0 12px 0;
  line-height: 1.4;
}

.product-sellpoint {
  font-size: 14px;
  color: var(--text-secondary, #666);
  margin: 0 0 20px 0;
  line-height: 1.6;
}

/* 价格区域 */
.price-section {
  background: linear-gradient(135deg, #fff9f5 0%, #fff5f0 100%);
  border-radius: var(--radius-md, 8px);
  padding: 20px;
  margin-bottom: 20px;
}

.price-row {
  display: flex;
  align-items: center;
  margin-bottom: 12px;
}

.price-row:last-child {
  margin-bottom: 0;
}

.price-row .label {
  width: 60px;
  font-size: 14px;
  color: var(--text-secondary, #666);
}

.price-row .price {
  font-size: 32px;
  font-weight: 700;
  color: var(--primary-color, #ff5000);
  font-family: "DIN Alternate", "Helvetica Neue", Arial, sans-serif;
}

.price-row .value {
  font-size: 14px;
  color: var(--text-primary, #333);
}

.price-row .value i {
  margin-right: 4px;
  color: var(--primary-color, #ff5000);
}

/* 商品信息 */
.info-section {
  padding: 20px 0;
  border-bottom: 1px solid var(--border-color, #e8e8e8);
}

.info-row {
  display: flex;
  align-items: center;
  margin-bottom: 16px;
}

.info-row:last-child {
  margin-bottom: 0;
}

.info-row .label {
  width: 60px;
  font-size: 14px;
  color: var(--text-secondary, #666);
}

.info-row .value {
  flex: 1;
  font-size: 14px;
  color: var(--text-primary, #333);
}

.service-tag {
  display: inline-flex;
  align-items: center;
  margin-right: 16px;
  color: var(--success-color, #52c41a);
  font-size: 13px;
}

.service-tag i {
  margin-right: 4px;
}

/* 操作按钮 */
.action-section {
  display: flex;
  gap: 16px;
  margin-top: 30px;
  padding-top: 20px;
}

.btn-cart,
.btn-buy {
  height: 50px;
  padding: 0 40px;
  font-size: 16px;
  border-radius: var(--radius-md, 8px);
}

.btn-cart {
  background: #fff;
  border: 2px solid var(--primary-color, #ff5000);
  color: var(--primary-color, #ff5000);
}

.btn-cart:hover {
  background: rgba(255, 80, 0, 0.05);
  border-color: var(--primary-dark, #e64500);
  color: var(--primary-dark, #e64500);
}

.btn-buy {
  background: linear-gradient(135deg, #ff5000 0%, #ff7433 100%);
  border: none;
  color: #fff;
}

.btn-buy:hover {
  background: linear-gradient(135deg, #e64500 0%, #ff5000 100%);
}

/* 商品详情区域 */
.detail-section {
  margin-top: 20px;
  background: #fff;
  border-radius: var(--radius-lg, 12px);
  overflow: hidden;
  box-shadow: var(--shadow-sm, 0 1px 2px rgba(0,0,0,0.06));
}

.section-header {
  padding: 20px 30px;
  border-bottom: 1px solid var(--border-color, #e8e8e8);
}

.section-header h2 {
  font-size: 18px;
  font-weight: 600;
  color: var(--text-primary, #333);
  margin: 0;
  display: flex;
  align-items: center;
  gap: 8px;
}

.section-header h2 i {
  color: var(--primary-color, #ff5000);
}

.section-content {
  padding: 30px;
  line-height: 1.8;
  color: var(--text-primary, #333);
}

.section-content >>> img {
  max-width: 100%;
  height: auto;
  border-radius: var(--radius-sm, 4px);
}
</style>
