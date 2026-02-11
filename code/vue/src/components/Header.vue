<template>
  <div style="height: 50px; line-height: 50px; border-bottom: 1px solid #ccc; display: flex">

    <div style="width: 200px; text-align: center; font-weight: bold; color: dodgerblue;font-size: 20px">商品后台管理</div>

    <div style="flex: 1;padding: 20px">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>系统管理</el-breadcrumb-item>
        <el-breadcrumb-item>{{getTitle($route.name)}}</el-breadcrumb-item>
      </el-breadcrumb>
    </div>

    <div style="width: 100px">
      <el-dropdown trigger="click">
        <span class="el-dropdown-link">
          {{user.username}}<i class="el-icon-arrow-down el-icon--right"></i>
        </span>
        <template #dropdown>
          <!--          想要直接在父组件触发click方法，需要加.native-->
          <el-dropdown-menu>
            <el-dropdown-item @click.native="$router.push('/person')">个人信息</el-dropdown-item>
            <el-dropdown-item @click.native="logOut()">退出系统</el-dropdown-item>
          </el-dropdown-menu>
        </template>
      </el-dropdown>
    </div>
  </div>
</template>

<script>
import router from "@/router";

export default {
  name: "Header",
  data(){
    return{
      user: {},
      // 写一个路径和页面名对应的hash表
      map:{
        order: "订单管理",
        item: "商品管理",
        user: "用户管理",
        description: "商品详情管理",
        advice: "查看建议"
      },
    }
  },
  created() {
    let str = sessionStorage.getItem('user') || '{}';
    // 赋值
    this.user = JSON.parse(str);
  },
  methods: {
    /*
    根据当前路由填充面包屑的标题,js 里面的 hashmap 取值是使用 [] 来取值
     */
    getTitle(name){
      return this.map[name];
    },

    logOut(){
      sessionStorage.clear();
      this.$message.success("您已登出");
      this.$router.push("/");
    }
  },
}
</script>

<style>
.el-dropdown-link {
  cursor: pointer;
  color: #409EFF;
}
.el-icon-arrow-down {
  font-size: 12px;
}
</style>