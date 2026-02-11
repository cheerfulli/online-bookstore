<template>
  <body>
  <div class="box">
    <h2 style="color: rgba(249,231,172);">欢迎注册</h2>
    <div class="input-box">
      <label>账号</label>
      <input type="text" v-model="form.username" placeholder="请输入用户名">
    </div>
    <div class="input-box">
      <label>密码</label>
      <input type="password" v-model="form.password" placeholder="请输入密码">
    </div>
    <div class="input-box">
      <label>确认密码</label>
      <!--      这里就不需要用.native来回传给父组件了，因为如果是el标签，相当于输入框是一个子组件，在里面的发生的事件要用.native绑定父组件，这里直接就是一个原生组件-->
      <input type="password" @keydown.enter="register()" v-model="form.confirm" placeholder="请确认您的密码">
    </div>
    <div class="btn-box">
      <div>
        <button style="width: 150px;margin-left: 70px" @click="register()">注册</button>
      </div>
    </div>
  </div>
  </body>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "LoginView",
  created() {
    document.title = '欢迎注册';
  },
  data() {
    return {
      // 提交的表单
      form: {
      }
    }
  },
  methods: {
    register() {
      // 简单判断一下空值
      if (this.form.username === undefined || this.form.username === ""){
        this.$message.error("用户名为空");
        return;
      }
      if (this.form.password === undefined || this.form.password === ""){
        this.$message.error("密码为空");
        return;
      }
      // 验证两次密码是否一致
      if (this.form.password !== this.form.confirm) {
        this.$message({
          type: "error",
          message: "两次密码不一致",
        });
        return
      }
      request.post('/user/register', this.form).then(res => {
        if (res.code === '0') {
          this.$message({
            type: 'success',
            message: "注册成功,请重新登录",
          });
          // 跳转登录页
          this.$router.push('/');
        } else {
          this.$message({
            type: 'error',
            message: res.msg,
          })
        }
      })
    }
  }
}
</script>

<style src="../assets/css/login.css" scoped>

</style>