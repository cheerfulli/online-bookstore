<template>
  <div>
    <div class="container">
      <div style="font-size: 40px">
        404 找不到页面
        <router-link to="/shop">跳转到首页</router-link>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "404"
}
</script>

<style scoped>
.container{
  height: 100vh;
  overflow: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>