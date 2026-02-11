<template>
  <div class="login_container">
    <div class="login_box">
      <!-- 头像区域 -->
      <div class="avatar_box">
        <img src="../assets/avatar.jpg" alt="" />
      </div>
      <!-- 登录表单 -->
      <el-form
          :model="form"
          :rules="rules" ref="loginForm"
          label-width="0px"
          class="login_form">
        <el-form-item prop="username">
          <el-input
              v-model="form.username"
              prefix-icon="el-icon-user"
              placeholder="请输入用户名"
          ></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input
              v-model="form.password"
              prefix-icon="el-icon-key"
              placeholder="请输入密码" type="password"
          ></el-input>
        </el-form-item>
        <el-form-item prop="validCode">
          <div style="display: flex">
            <el-input
                v-model="form.validCode" style="width: 50%"
                prefix-icon="el-icon-lock" @keydown.enter.native = "login"
                placeholder="请输入验证码"></el-input>
            <!--  这里不能带()，因为这是个有参函数，直接写函数名就可以了-->
            <ValidCode @input="getValidCode" style="margin-left: 60px" ref="child"></ValidCode>
          </div>
        </el-form-item>
        <el-form-item class="btns">
          <el-button type="primary" round style="background-color: lightcoral; border: 1px solid #eee"
              @click="login()">登录</el-button>
          <el-button
              type="info"
              round
              @click="$router.push('/register')"
              style="background-color: #0661d7; border: 1px solid #eee"
          >注册</el-button>
        </el-form-item>
        <el-form-item class="jump">
          <a @click="jump()">管理员登录 ---></a>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
import ValidCode from "@/components/ValidCode.vue";
import request from "@/utils/request";

export default {
  name: "Login",
  created() {
    document.title = '欢迎登录';
  },
  components:{
    ValidCode,
  },
  data() {
    return {
      form: {
        username:'admin',
        password: '123'
      },
      validCode: "",
      // 表单数据验证规则
      rules: {
        username: [
          { required: true, message: "请输入用户昵称:)", trigger: "blur" },
          {
            min: 2,
            max: 25,
            message: "长度在 2 到 25 个字符",
            trigger: "blur",
          },
        ],
        password: [
          { required: true, message: "请输入密码~~", trigger: "blur" },
          { min: 1, max: 15, message: "长度在 1到 15 个字符", trigger: "blur" },
        ],
        validCode: [
          { required: true, message: "请输入验证码~~", trigger: "blur" }
        ],
      },
    }
  },
  methods: {
    // 从验证码子组件里面获取正确的验证码
    getValidCode(data){
      this.validCode = data;
    },
    login() {
      this.$refs['loginForm'].validate((valid) => {
        // 如果满足输入的规则
        if (valid){
          // 验证码不正确
          if (this.form.validCode.toLowerCase() !== this.validCode.toLowerCase()){
            this.$message.error('验证码错误');
            // 更新验证码
            this.$refs.child.refreshCode();
            return;
          }
          // 出来了就是验证码正确，就发送给后端
          request.post('/user/login', this.form).then(res => {
            if (res.code === '0') {
              this.$message({
                type: 'success',
                message: "登录成功",
              });
              // 缓存用户信息
              sessionStorage.setItem("user", JSON.stringify(res.data));
              // 跳转主页，检测用户的角色是否为管理员，role为1就跳转到管理页面
              this.$router.push('/shop');
            } else {
              this.$message({
                type: 'error',
                message: res.msg,
              })
            }
          });
        }
      });
    },
    jump(){
      this.$router.push('/manageLogin');
    }
  }
}
</script>

<style lang="less" scoped>
.login_container {
  background-color: lightcoral;
  height: 100vh;
}
.login_box {
  width: 450px;
  height: 350px;
  background: #fff;
  border-radius: 3px;
  box-shadow: 0 0 10px #ddd; //阴影
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
  .avatar_box {
    height: 130px;
    width: 130px;
    border: 1px solid #eee;
    border-radius: 50%;
    padding: 10px; //头像图片和头像盒子的距离
    box-shadow: 0 0 10px #ddd;
    position: absolute;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: #938ad9;
  }
  .avatar_box img {
    width: 100%;
    height: 100%;
    border-radius: 50%;
    background-color: #eee;
  }

}
.login_form {
  position: absolute;
  bottom: 5%;
  width: 100%;
  padding: 0 20px;
  box-sizing: border-box;
}
.btns {
  display: flex;
  justify-content: flex-end;
  background-color: #eee;
}
.jump {
  display: flex;
  margin-left: 180px;
  font-style: italic;
  color: #409EFF;
}
.jump:hover{
  cursor: pointer;
}
</style>