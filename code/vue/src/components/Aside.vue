<template>
  <div>
<!--    是否使用 vue-router 的模式，启用该模式会在激活导航时以 index 作为 path 进行路由跳转-->
    <el-menu style="width: 205px;height: 100%;min-height: 710px"
             router background-color="rgba(43,60,81)" text-color="#fff"
             :default-active="this.$route.path"
             class="el-menu-vertical-demo">
      <el-submenu index="1">
        <template #title>
          <i class="el-icon-location"></i>
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
          <i class="el-icon-s-shop"></i>
          <span>订单管理</span>
        </el-menu-item>
        <el-menu-item index="/description">
          <i class="el-icon-more-outline"></i>
          <span>图书详情管理</span>
        </el-menu-item>
      </el-submenu>
      <el-menu-item index="/refund">
        <i class="el-icon-eleme"></i>
        <span slot="title">退款订单</span>
      </el-menu-item>
      <el-menu-item index="/advice">
        <i class="el-icon-edit-outline"></i>
        <span slot="title">查看建议</span>
      </el-menu-item>
      <el-menu-item index="/charts">
        <i class="el-icon-s-platform"></i>
        <span slot="title">数据分析</span>
      </el-menu-item>
      <el-menu-item index="/shop">
        <i class="el-icon-menu"></i>
        <span slot="title">前往商城</span>
      </el-menu-item>
    </el-menu>
  </div>
</template>

<script>
export default {
  name: "Aside",
  data(){
    return{
    }
  },
  methods: {

  }
}
</script>

<style scoped>

</style>