<!--我的淘宝主体框架-->
<template>
  <div>
    <!--    顶部栏-->
    <div class="topBar">
      <!--      顶部图标-->
      <!-- <a href="/mine" style="margin-left: 170px"><img src="@/assets/images/my-shop.png" alt="MyShop" style="width: 205px;height: 48px"></a> -->
      <!--      搜索框-->
      <!-- <div style="float: right;width: 700px">
        <el-input @keydown.enter.native="loadData" size="big" v-model="search" placeholder="请输入你搜索的商品关键词"
                  style="width: 40%;margin-left: 100px" clearable></el-input>
        <el-button type="danger" style="margin-left: 25px" icon="el-icon-search" size="big" @click="loadData">搜索</el-button>
      </div> -->
    </div>

    <!--    个人中心router-->
    <div style="background-color: white;margin: 10px 200px;flex: auto;height: auto;display: flex">
      <!--      侧边栏-->
      <div style="width: 180px">
        <el-menu style="height: 775px"
                 router
                 :default-active="this.$route.path"
                 text-color="rgba(255,91,24)"
                 class="el-menu-vertical-demo">
          <el-menu-item index="/mine">
            <i class="el-icon-user"></i>
            <span slot="title">我的信息</span>
          </el-menu-item>
          <el-menu-item index="/cart">
            <i class="el-icon-shopping-cart-2"></i>
            <span slot="title">我的购物车</span>
          </el-menu-item>
          <el-menu-item index="/myOrder">
            <i class="el-icon-shopping-bag-2"></i>
            <span slot="title">我的订单</span>
          </el-menu-item>
          <el-menu-item index="/customerServ">
            <i class="el-icon-phone-outline"></i>
            <span slot="title">联系客服</span>
          </el-menu-item>
          <el-menu-item index="/addressManage">
            <i class="el-icon-location-outline"></i>
            <span slot="title">地址管理</span>
          </el-menu-item>
     
        </el-menu>
      </div>
      <!--      主体内容显示-->
      <div>
        <router-view></router-view>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "MyLayout",
  data(){
    return{
      search: "",
    }
  },
  methods: {
    loadData(){

    }
  }
}
</script>

<style scoped>
.topBar{
  /* style="background-color: rgba(255,68,1);padding: 20px" */
  background-color: rgb(148, 192, 224);
  padding: 20px
}
</style>