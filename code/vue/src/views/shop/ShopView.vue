<template>
  <div class="shop-container">
    <!-- 搜索栏 -->
    <div class="search-bar">
      <div class="search-content">
        <div class="brand-name">
          <i class="el-icon-reading"></i>
          天大书店
        </div>
        <div class="search-box">
          <el-input
            v-model="search"
            placeholder="搜索书籍、作者、关键词..."
            @keydown.enter.native="loadData"
            class="search-input"
            clearable
          >
            <template #prefix>
              <i class="el-icon-search"></i>
            </template>
          </el-input>
          <el-button type="primary" class="search-btn" @click="loadData">
            搜索
          </el-button>
        </div>
      </div>
    </div>

    <!-- 轮播图 -->
    <div class="carousel-section">
      <el-carousel height="420px" indicator-position="outside">
        <el-carousel-item v-for="(item, index) in imgArray" :key="index">
          <img :src="item" class="carousel-img" alt="banner">
        </el-carousel-item>
      </el-carousel>
    </div>

    <!-- 商品列表 -->
    <div class="products-section">
      <div class="section-header">
        <h2><i class="el-icon-s-goods"></i> 精选图书</h2>
        <span class="subtitle">发现你的下一本好书</span>
      </div>

      <el-row :gutter="20" class="products-grid">
        <el-col :span="6" v-for="item in itemData" :key="item.id">
          <a :href="'/shop/detail?id=' + item.id" class="product-link">
            <el-card class="product-card" :body-style="{ padding: '0' }">
              <div class="product-image">
                <img :src="item.image ? item.image : defaultImg" :alt="item.title">
              </div>
              <div class="product-info">
                <h3 class="product-title">{{ item.title }}</h3>
                <p class="product-desc">{{ item.sellPoint }}</p>
                <div class="product-footer">
                  <span class="product-price">¥{{ item.price }}</span>
                  <span class="product-action">
                    <i class="el-icon-shopping-cart-2"></i>
                  </span>
                </div>
              </div>
            </el-card>
          </a>
        </el-col>
      </el-row>

      <!-- 空状态 -->
      <div v-if="itemData.length === 0" class="empty-state">
        <i class="el-icon-search"></i>
        <p>暂无相关书籍</p>
      </div>
    </div>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "ShopView",
  data() {
    return {
      search: '',
      itemData: [],
      defaultImg: "https://shadow.elemecdn.com/app/element/hamburger.9cf7b091-55e9-11e9-a976-7f4d0b07eef6.png",
      imgArray: [
        require('@/assets/images/pc1.jpg'),
        require('@/assets/images/pc2.jpg'),
        require('@/assets/images/pc3.jpg'),
        require('@/assets/images/pc4.jpg')
      ]
    };
  },
  created() {
    this.loadData();
    document.title = "TJU网上书店 - 首页"
  },
  methods: {
    loadData() {
      request.get('/item/getAll', {
        params: {
          search: this.search,
        }
      }).then(res => {
        this.itemData = res.data;
      })
    }
  }
}
</script>

<style scoped>
.shop-container {
  background-color: var(--bg-page, #f5f5f5);
  min-height: 100vh;
}

/* 搜索栏 */
.search-bar {
  background: linear-gradient(135deg, #fff9f5 0%, #ffffff 100%);
  padding: 20px 0;
  box-shadow: var(--shadow-sm, 0 1px 2px rgba(0,0,0,0.06));
}

.search-content {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 20px;
}

.brand-name {
  font-size: 28px;
  font-weight: 600;
  color: var(--primary-color, #ff5000);
  display: flex;
  align-items: center;
  gap: 8px;
}

.brand-name i {
  font-size: 32px;
}

.search-box {
  display: flex;
  align-items: center;
  gap: 12px;
}

.search-input {
  width: 400px;
}

.search-input >>> .el-input__inner {
  border-radius: 24px;
  padding-left: 40px;
  height: 44px;
  border: 2px solid #eee;
}

.search-input >>> .el-input__inner:focus {
  border-color: var(--primary-color, #ff5000);
}

.search-input >>> .el-input__prefix {
  left: 15px;
  color: #999;
}

.search-btn {
  height: 44px;
  padding: 0 28px;
  border-radius: 24px;
  font-size: 15px;
  background: linear-gradient(135deg, #ff5000 0%, #ff7433 100%);
  border: none;
}

.search-btn:hover {
  background: linear-gradient(135deg, #e64500 0%, #ff5000 100%);
}

/* 轮播图 */
.carousel-section {
  max-width: 1200px;
  margin: 20px auto;
  padding: 0 20px;
}

.carousel-section >>> .el-carousel__container {
  border-radius: var(--radius-lg, 12px);
  overflow: hidden;
}

.carousel-img {
  width: 100%;
  height: 420px;
  object-fit: cover;
}

.carousel-section >>> .el-carousel__indicator.is-active button {
  background-color: var(--primary-color, #ff5000);
}

/* 商品列表 */
.products-section {
  max-width: 1200px;
  margin: 0 auto;
  padding: 30px 20px 50px;
}

.section-header {
  margin-bottom: 24px;
  display: flex;
  align-items: baseline;
  gap: 12px;
}

.section-header h2 {
  font-size: 22px;
  color: var(--text-primary, #333);
  display: flex;
  align-items: center;
  gap: 8px;
}

.section-header h2 i {
  color: var(--primary-color, #ff5000);
}

.section-header .subtitle {
  font-size: 14px;
  color: var(--text-secondary, #666);
}

.products-grid {
  margin-top: 20px;
}

.products-grid .el-col {
  margin-bottom: 20px;
}

/* 商品卡片 */
.product-link {
  display: block;
  text-decoration: none;
}

.product-card {
  border-radius: var(--radius-md, 8px);
  overflow: hidden;
  background: #fff;
  height: 100%;
}

.product-card:hover {
  transform: translateY(-6px);
  box-shadow: var(--shadow-hover, 0 6px 16px rgba(255,80,0,0.15));
}

.product-image {
  width: 100%;
  height: 200px;
  overflow: hidden;
  background: #f9f9f9;
}

.product-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s ease;
}

.product-card:hover .product-image img {
  transform: scale(1.05);
}

.product-info {
  padding: 16px;
}

.product-title {
  font-size: 15px;
  font-weight: 500;
  color: var(--text-primary, #333);
  margin: 0 0 8px 0;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.product-card:hover .product-title {
  color: var(--primary-color, #ff5000);
}

.product-desc {
  font-size: 12px;
  color: var(--text-secondary, #666);
  line-height: 1.5;
  height: 36px;
  overflow: hidden;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  margin: 0 0 12px 0;
}

.product-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.product-price {
  font-size: 20px;
  font-weight: 600;
  color: var(--primary-color, #ff5000);
  font-family: "DIN Alternate", "Helvetica Neue", Arial, sans-serif;
}

.product-action {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background: linear-gradient(135deg, #ff5000 0%, #ff7433 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  color: #fff;
  font-size: 16px;
  cursor: pointer;
  transition: all 0.25s ease;
}

.product-action:hover {
  transform: scale(1.1);
  box-shadow: 0 4px 12px rgba(255, 80, 0, 0.3);
}

/* 空状态 */
.empty-state {
  text-align: center;
  padding: 60px 0;
  color: var(--text-placeholder, #999);
}

.empty-state i {
  font-size: 48px;
  margin-bottom: 16px;
}

.empty-state p {
  font-size: 14px;
}
</style>
