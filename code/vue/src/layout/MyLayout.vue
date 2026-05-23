<!--用户中心主体框架-->
<template>
  <div class="my-layout">
    <!-- 顶部栏 -->
    <div class="top-bar">
      <div class="top-content">
        <div class="user-welcome">
          <i class="el-icon-user-solid"></i>
          <span>个人中心</span>
        </div>
        <div class="quick-links">
          <a @click="$router.push('/shop')">
            <i class="el-icon-s-home"></i> 返回首页
          </a>
        </div>
      </div>
    </div>

    <!-- 主体区域 -->
    <div class="main-container">
      <!-- 侧边栏 -->
      <div class="sidebar">
        <div class="user-card">
          <div class="avatar">
            <i class="el-icon-user"></i>
          </div>
          <div class="user-name">{{ user.username || '用户' }}</div>
        </div>

        <el-menu
          class="side-menu"
          router
          :default-active="$route.path"
        >
          <el-menu-item index="/mine">
            <i class="el-icon-user"></i>
            <span slot="title">我的信息</span>
          </el-menu-item>
          <el-menu-item index="/cart">
            <i class="el-icon-shopping-cart-2"></i>
            <span slot="title">我的购物车</span>
          </el-menu-item>
          <el-menu-item index="/myOrder">
            <i class="el-icon-document"></i>
            <span slot="title">我的订单</span>
          </el-menu-item>
          <el-menu-item index="/customerServ">
            <i class="el-icon-service"></i>
            <span slot="title">联系客服</span>
          </el-menu-item>
          <el-menu-item index="/addressManage">
            <i class="el-icon-location-outline"></i>
            <span slot="title">地址管理</span>
          </el-menu-item>
        </el-menu>
      </div>

      <!-- 主体内容 -->
      <div class="content-area">
        <router-view></router-view>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "MyLayout",
  data() {
    return {
      user: {}
    }
  },
  created() {
    let str = sessionStorage.getItem('user') || '{}';
    this.user = JSON.parse(str);
  }
}
</script>

<style scoped>
.my-layout {
  min-height: 100vh;
  background-color: var(--bg-page, #f5f5f5);
}

/* 顶部栏 */
.top-bar {
  background: linear-gradient(135deg, #ff5000 0%, #ff7433 100%);
  padding: 0;
  box-shadow: 0 2px 8px rgba(255, 80, 0, 0.2);
}

.top-content {
  max-width: 1600px;
  margin: 0 auto;
  padding: 16px 40px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

@media (max-width: 1400px) {
  .top-content {
    max-width: 100%;
    padding-left: 24px;
    padding-right: 24px;
  }
}

.user-welcome {
  display: flex;
  align-items: center;
  gap: 8px;
  color: #fff;
  font-size: 18px;
  font-weight: 500;
}

.user-welcome i {
  font-size: 22px;
}

.quick-links a {
  color: rgba(255, 255, 255, 0.9);
  font-size: 14px;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 4px;
  padding: 6px 12px;
  border-radius: 4px;
  transition: all 0.25s ease;
}

.quick-links a:hover {
  background: rgba(255, 255, 255, 0.15);
  color: #fff;
}

/* 主体区域 */
.main-container {
  max-width: 1600px;
  margin: 20px auto;
  padding: 0 40px;
  display: flex;
  gap: 24px;
}

@media (max-width: 1400px) {
  .main-container {
    max-width: 100%;
    padding-left: 24px;
    padding-right: 24px;
  }
}

/* 侧边栏 */
.sidebar {
  width: 220px;
  flex-shrink: 0;
}

.user-card {
  background: #fff;
  border-radius: var(--radius-lg, 12px);
  padding: 24px;
  text-align: center;
  margin-bottom: 16px;
  box-shadow: var(--shadow-sm, 0 1px 2px rgba(0,0,0,0.06));
}

.avatar {
  width: 72px;
  height: 72px;
  border-radius: 50%;
  background: linear-gradient(135deg, #ff5000 0%, #ff7433 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 12px;
}

.avatar i {
  font-size: 36px;
  color: #fff;
}

.user-name {
  font-size: 16px;
  font-weight: 500;
  color: var(--text-primary, #333);
}

.side-menu {
  background: #fff;
  border-radius: var(--radius-lg, 12px);
  overflow: hidden;
  box-shadow: var(--shadow-sm, 0 1px 2px rgba(0,0,0,0.06));
  border: none;
  padding: 8px;
}

.side-menu .el-menu-item {
  height: 48px;
  line-height: 48px;
  margin: 4px 0;
  border-radius: var(--radius-md, 8px);
  color: var(--text-secondary, #666);
  transition: all 0.25s ease;
}

.side-menu .el-menu-item i {
  margin-right: 8px;
  font-size: 18px;
}

.side-menu .el-menu-item:hover {
  background: rgba(255, 80, 0, 0.05);
  color: var(--primary-color, #ff5000);
}

.side-menu .el-menu-item.is-active {
  background: linear-gradient(135deg, rgba(255, 80, 0, 0.1) 0%, rgba(255, 116, 51, 0.1) 100%);
  color: var(--primary-color, #ff5000);
  font-weight: 500;
}

/* 内容区域 */
.content-area {
  flex: 1;
  background: #fff;
  border-radius: var(--radius-lg, 12px);
  box-shadow: var(--shadow-sm, 0 1px 2px rgba(0,0,0,0.06));
  min-height: 600px;
  overflow: hidden;
}
</style>
