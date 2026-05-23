<template>
  <footer class="site-footer">
    <div class="footer-main">
      <div class="footer-content">
        <!-- 品牌区域 -->
        <div class="footer-brand">
          <div class="brand-logo">
            <i class="el-icon-reading"></i>
            <span>TJU网上书店</span>
          </div>
          <p class="brand-slogan">您身边的知识伙伴</p>
          <p class="brand-desc">致力于为读者提供优质的图书和便捷的购物体验</p>
        </div>

        <!-- 快捷链接 -->
        <div class="footer-links">
          <h4>快捷导航</h4>
          <ul>
            <li><a href="/shop"><i class="el-icon-s-home"></i> 首页</a></li>
            <li><a href="/mine"><i class="el-icon-user"></i> 个人中心</a></li>
            <li><a href="/cart"><i class="el-icon-shopping-cart-2"></i> 购物车</a></li>
            <li><a href="/myOrder"><i class="el-icon-document"></i> 我的订单</a></li>
          </ul>
        </div>

        <!-- 客户服务 -->
        <div class="footer-service">
          <h4>客户服务</h4>
          <ul>
            <li><a href="/customerServ"><i class="el-icon-service"></i> 联系客服</a></li>
            <li><a href="/addressManage"><i class="el-icon-location"></i> 地址管理</a></li>
            <li><span><i class="el-icon-phone"></i> 服务热线：400-XXX-XXXX</span></li>
          </ul>
        </div>

        <!-- 服务保障 -->
        <div class="footer-guarantee">
          <h4>服务保障</h4>
          <div class="guarantee-items">
            <div class="guarantee-item">
              <i class="el-icon-check"></i>
              <span>正品保障</span>
            </div>
            <div class="guarantee-item">
              <i class="el-icon-check"></i>
              <span>七天无理由</span>
            </div>
            <div class="guarantee-item">
              <i class="el-icon-check"></i>
              <span>全国包邮</span>
            </div>
            <div class="guarantee-item">
              <i class="el-icon-check"></i>
              <span>安全支付</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 版权信息 -->
    <div class="footer-bottom">
      <div class="footer-bottom-content">
        <p class="copyright">
          Copyright © 2024 <span class="highlight">TJU网上书店</span> All Rights Reserved.
        </p>
        <p class="icp">天津大学 · 软件工程课程设计</p>
      </div>
    </div>
  </footer>
</template>

<script>
export default {
  name: "NavFooter"
}
</script>

<style scoped>
.site-footer {
  background: #2c3e50;
  color: #bdc3c7;
  margin-top: 40px;
}

.footer-main {
  border-top: 4px solid var(--primary-color, #ff5000);
}

.footer-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 50px 20px 40px;
  display: grid;
  grid-template-columns: 2fr 1fr 1fr 1.5fr;
  gap: 40px;
}

/* 品牌区域 */
.footer-brand {
  padding-right: 40px;
}

.brand-logo {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 22px;
  font-weight: 600;
  color: #fff;
  margin-bottom: 12px;
}

.brand-logo i {
  font-size: 28px;
  color: var(--primary-color, #ff5000);
}

.brand-slogan {
  font-size: 14px;
  color: var(--primary-color, #ff5000);
  margin: 0 0 12px 0;
}

.brand-desc {
  font-size: 13px;
  line-height: 1.6;
  color: #95a5a6;
  margin: 0;
}

/* 链接区域 */
.footer-links h4,
.footer-service h4,
.footer-guarantee h4 {
  font-size: 15px;
  font-weight: 600;
  color: #fff;
  margin: 0 0 20px 0;
  padding-bottom: 10px;
  border-bottom: 2px solid rgba(255, 80, 0, 0.3);
}

.footer-links ul,
.footer-service ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

.footer-links li,
.footer-service li {
  margin-bottom: 12px;
}

.footer-links a,
.footer-service a,
.footer-service span {
  color: #95a5a6;
  font-size: 13px;
  text-decoration: none;
  display: flex;
  align-items: center;
  gap: 8px;
  transition: all 0.25s ease;
}

.footer-links a:hover,
.footer-service a:hover {
  color: var(--primary-color, #ff5000);
  padding-left: 4px;
}

.footer-links i,
.footer-service i {
  font-size: 14px;
  width: 16px;
}

/* 服务保障 */
.guarantee-items {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 12px;
}

.guarantee-item {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 13px;
  color: #95a5a6;
}

.guarantee-item i {
  color: var(--success-color, #52c41a);
  font-size: 14px;
}

/* 版权信息 */
.footer-bottom {
  background: rgba(0, 0, 0, 0.2);
}

.footer-bottom-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
  text-align: center;
}

.copyright {
  font-size: 13px;
  color: #7f8c8d;
  margin: 0 0 6px 0;
}

.copyright .highlight {
  color: var(--primary-color, #ff5000);
}

.icp {
  font-size: 12px;
  color: #5d6d7e;
  margin: 0;
}

/* 响应式 */
@media (max-width: 900px) {
  .footer-content {
    grid-template-columns: 1fr 1fr;
  }
}

@media (max-width: 600px) {
  .footer-content {
    grid-template-columns: 1fr;
    text-align: center;
  }

  .footer-brand {
    padding-right: 0;
  }

  .brand-logo {
    justify-content: center;
  }

  .footer-links a,
  .footer-service a,
  .footer-service span {
    justify-content: center;
  }

  .guarantee-items {
    justify-content: center;
  }
}
</style>
