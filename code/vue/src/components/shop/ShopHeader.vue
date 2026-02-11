<template>
  <div style="height: 50px; line-height: 50px; border-bottom: 1px solid #ccc; display: flex">
    <div><a href="/shop" style="width: 200px; padding-left: 30px; font-weight: bold; color: #d71d3f;font-size: 20px">欢迎来到tju网上书店</a></div>
    <div style="flex: 1;margin-left: 25px">
      <!--    用户名显示-->
      <el-tag type="success" class="label" size="big">
        <el-dropdown trigger="click">
        <span class="el-dropdown-link" >
          Hi, {{user.username}}
          <i class="el-icon-arrow-down el-icon--right"></i>
        </span>
          <template #dropdown>
            <!--          想要直接在父组件触发click方法，需要加.native-->
            <el-dropdown-menu>
              <el-dropdown-item @click.native="$router.push('/mine')">个人信息</el-dropdown-item>
              <el-dropdown-item @click.native="logOff">退出系统</el-dropdown-item>
            </el-dropdown-menu>
          </template>
        </el-dropdown>
      </el-tag>
      <el-tag type="success" class="label" size="big" @click="$router.push('/register')">免费注册</el-tag>
      <el-tag type="success" class="label" size="big" @click="goPhone">学校官网</el-tag>
      <!-- <el-tag type="success" class="label" size="big" @click="$message.warning('功能开发中~~~')">网页无障碍</el-tag> -->
    </div>
    <div>
      <el-tag type="warning" class="label" size="big" @click="$router.push('/mine')">我的Shop</el-tag>
      <el-tag type="warning" class="label" size="big" @click="$router.push('/cart')">购物车</el-tag>
      <el-tag type="warning" class="label" size="big" @click="$router.push('/myOrder')">我的订单</el-tag>
      <el-tag type="warning" class="label" size="big" @click="$router.push('/addressManage')">地址管理</el-tag>
      <el-tag type="warning" class="label" size="big" @click="$router.push('/customerServ')">联系客服</el-tag>
    </div>
  </div>
</template>

<script>
export default {
  name: "Header",
  data(){
    return{
      user: {}
    }
  },
  created() {
    let str = sessionStorage.getItem('user') || '{}';
    // 赋值
    this.user = JSON.parse(str);
  },
  methods: {
    goPhone(){
      window.open('https://www.tju.edu.cn/')
    },

    logOff(){
      sessionStorage.clear();
      this.$message.success("您已登出");
      this.$router.push("/");
    }
  }
}
</script>

<style>
.el-tag{
  cursor: pointer;
}
.el-dropdown-link {
  cursor: pointer;
  color: #409EFF;
}
.el-icon-arrow-down {
  font-size: 12px;
}
.label{
  margin: 0 10px;
}
</style>