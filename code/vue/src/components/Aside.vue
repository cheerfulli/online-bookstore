<template>
  <div class="admin-aside">
    <!-- Logo区域 -->
    <div class="aside-logo">
      <i class="el-icon-reading"></i>
      <span>管理后台</span>
    </div>

    <!-- 菜单 -->
    <el-menu
      class="aside-menu"
      router
      :default-active="$route.path"
      background-color="transparent"
      text-color="rgba(255,255,255,0.7)"
      active-text-color="#ff5000"
    >
      <el-submenu index="1">
        <template #title>
          <i class="el-icon-setting"></i>
          <span>系统管理</span>
        </template>
        <el-menu-item index="/user">
          <i class="el-icon-user"></i>
          <span>用户管理</span>
        </el-menu-item>
        <el-menu-item index="/item">
          <i class="el-icon-goods"></i>
          <span>图书管理</span>
        </el-menu-item>
        <el-menu-item index="/order">
          <i class="el-icon-s-order"></i>
          <span>订单管理</span>
        </el-menu-item>
        <el-menu-item index="/description">
          <i class="el-icon-document"></i>
          <span>图书详情</span>
        </el-menu-item>
      </el-submenu>

      <el-menu-item index="/refund">
        <i class="el-icon-refresh-left"></i>
        <span slot="title">退款订单</span>
      </el-menu-item>

      <el-menu-item index="/advice">
        <i class="el-icon-chat-dot-round"></i>
        <span slot="title">用户建议</span>
      </el-menu-item>

      <el-menu-item index="/charts">
        <i class="el-icon-data-analysis"></i>
        <span slot="title">数据分析</span>
      </el-menu-item>

      <div class="menu-divider"></div>

      <el-menu-item index="/shop" class="menu-item-shop">
        <i class="el-icon-s-home"></i>
        <span slot="title">前往商城</span>
      </el-menu-item>
    </el-menu>
  </div>
</template>

<script>
export default {
  name: "Aside",
  data() {
    return {}
  }
}
</script>

<style scoped>
.admin-aside {
  width: 220px;
  min-height: 100vh;
  background: linear-gradient(180deg, #2c3e50 0%, #1a252f 100%);
  display: flex;
  flex-direction: column;
}

/* Logo区域 */
.aside-logo {
  height: 60px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.aside-logo i {
  font-size: 26px;
  color: #ff5000;
}

.aside-logo span {
  font-size: 18px;
  font-weight: 600;
  color: #fff;
}

/* 菜单 */
.aside-menu {
  flex: 1;
  border: none;
  padding: 12px 8px;
}

.aside-menu >>> .el-menu-item,
.aside-menu >>> .el-submenu__title {
  height: 46px;
  line-height: 46px;
  margin: 4px 0;
  border-radius: 8px;
  transition: all 0.25s ease;
}

.aside-menu >>> .el-menu-item i,
.aside-menu >>> .el-submenu__title i {
  margin-right: 10px;
  font-size: 18px;
}

.aside-menu >>> .el-menu-item:hover,
.aside-menu >>> .el-submenu__title:hover {
  background: rgba(255, 80, 0, 0.1) !important;
}

.aside-menu >>> .el-menu-item.is-active {
  background: linear-gradient(135deg, rgba(255, 80, 0, 0.2) 0%, rgba(255, 116, 51, 0.15) 100%) !important;
  color: #ff5000 !important;
  font-weight: 500;
  position: relative;
}

.aside-menu >>> .el-menu-item.is-active::before {
  content: '';
  position: absolute;
  left: 0;
  top: 50%;
  transform: translateY(-50%);
  width: 3px;
  height: 20px;
  background: #ff5000;
  border-radius: 0 2px 2px 0;
}

/* 子菜单 */
.aside-menu >>> .el-submenu .el-menu-item {
  padding-left: 50px !important;
  height: 42px;
  line-height: 42px;
}

.aside-menu >>> .el-submenu.is-opened > .el-submenu__title {
  color: #fff !important;
}

.aside-menu >>> .el-submenu.is-opened > .el-submenu__title i {
  color: #ff5000;
}

/* 分隔线 */
.menu-divider {
  height: 1px;
  background: rgba(255, 255, 255, 0.1);
  margin: 16px 12px;
}

/* 前往商城按钮 */
.menu-item-shop {
  margin-top: auto;
}

.aside-menu >>> .menu-item-shop {
  background: rgba(255, 80, 0, 0.1) !important;
  color: #ff5000 !important;
}

.aside-menu >>> .menu-item-shop:hover {
  background: rgba(255, 80, 0, 0.2) !important;
}
</style>
