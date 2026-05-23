<template>
  <div class="shop-header">
    <!-- Logo区域 -->
    <div class="header-logo">
      <a href="/shop">
        <i class="el-icon-reading"></i>
        <span>TJU网上书店</span>
      </a>
    </div>

    <!-- 左侧导航 -->
    <div class="header-left">
      <el-dropdown trigger="click" class="user-dropdown">
        <span class="user-info">
          <i class="el-icon-user-solid"></i>
          Hi, {{ user.username || '游客' }}
          <i class="el-icon-arrow-down"></i>
        </span>
        <template #dropdown>
          <el-dropdown-menu>
            <el-dropdown-item @click.native="$router.push('/mine')">
              <i class="el-icon-user"></i> 个人信息
            </el-dropdown-item>
            <el-dropdown-item @click.native="logOff" divided>
              <i class="el-icon-switch-button"></i> 退出登录
            </el-dropdown-item>
          </el-dropdown-menu>
        </template>
      </el-dropdown>

      <a class="nav-link" @click="$router.push('/register')">
        <i class="el-icon-plus"></i> 免费注册
      </a>
      <a class="nav-link" @click="goPhone">
        <i class="el-icon-school"></i> 学校官网
      </a>
    </div>

    <!-- 右侧导航 -->
    <div class="header-right">
      <a class="nav-item" @click="$router.push('/mine')">
        <i class="el-icon-user"></i>
        <span>我的Shop</span>
      </a>
      <a class="nav-item" @click="$router.push('/cart')">
        <i class="el-icon-shopping-cart-2"></i>
        <span>购物车</span>
      </a>
      <a class="nav-item" @click="$router.push('/myOrder')">
        <i class="el-icon-document"></i>
        <span>我的订单</span>
      </a>
      <a class="nav-item" @click="$router.push('/addressManage')">
        <i class="el-icon-location-outline"></i>
        <span>地址管理</span>
      </a>
      <a class="nav-item highlight" @click="$router.push('/customerServ')">
        <i class="el-icon-service"></i>
        <span>联系客服</span>
      </a>
    </div>
  </div>
</template>

<script>
export default {
  name: "ShopHeader",
  data() {
    return {
      user: {}
    }
  },
  created() {
    let str = sessionStorage.getItem('user') || '{}';
    this.user = JSON.parse(str);
  },
  methods: {
    goPhone() {
      window.open('https://www.tju.edu.cn/')
    },
    logOff() {
      sessionStorage.clear();
      this.$message.success("您已登出");
      this.$router.push("/");
    }
  }
}
</script>

<style scoped>
.shop-header {
  height: 56px;
  background: #fff;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
  display: flex;
  align-items: center;
  padding: 0 24px;
  position: relative;
  z-index: 100;
}

/* Logo */
.header-logo a {
  display: flex;
  align-items: center;
  font-size: 20px;
  font-weight: 600;
  color: var(--primary-color, #ff5000);
  text-decoration: none;
}

.header-logo i {
  font-size: 24px;
  margin-right: 8px;
}

/* 左侧导航 */
.header-left {
  flex: 1;
  display: flex;
  align-items: center;
  margin-left: 40px;
  gap: 8px;
}

.user-dropdown {
  cursor: pointer;
}

.user-info {
  display: flex;
  align-items: center;
  padding: 6px 12px;
  background: linear-gradient(135deg, #ff5000 0%, #ff7433 100%);
  color: #fff;
  border-radius: 20px;
  font-size: 13px;
  cursor: pointer;
}

.user-info i:first-child {
  margin-right: 4px;
}

.user-info .el-icon-arrow-down {
  margin-left: 4px;
  font-size: 10px;
}

.nav-link {
  padding: 6px 12px;
  color: var(--text-secondary, #666);
  font-size: 13px;
  cursor: pointer;
  border-radius: 4px;
  display: flex;
  align-items: center;
}

.nav-link:hover {
  color: var(--primary-color, #ff5000);
  background: rgba(255, 80, 0, 0.05);
}

.nav-link i {
  margin-right: 4px;
}

/* 右侧导航 */
.header-right {
  display: flex;
  align-items: center;
  gap: 4px;
}

.nav-item {
  padding: 8px 14px;
  color: var(--text-secondary, #666);
  font-size: 13px;
  cursor: pointer;
  border-radius: 4px;
  display: flex;
  align-items: center;
  transition: all 0.25s ease;
}

.nav-item:hover {
  color: var(--primary-color, #ff5000);
  background: rgba(255, 80, 0, 0.05);
}

.nav-item i {
  margin-right: 4px;
  font-size: 15px;
}

.nav-item.highlight {
  background: linear-gradient(135deg, #ff5000 0%, #ff7433 100%);
  color: #fff;
}

.nav-item.highlight:hover {
  background: linear-gradient(135deg, #e64500 0%, #ff5000 100%);
  color: #fff;
}

/* 下拉菜单样式 */
.el-dropdown-menu__item i {
  margin-right: 8px;
}
</style>
