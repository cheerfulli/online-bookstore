<template>
  <div class="login-page">
    <!-- 背景装饰 -->
    <div class="bg-decoration">
      <div class="circle circle-1"></div>
      <div class="circle circle-2"></div>
      <div class="circle circle-3"></div>
    </div>

    <!-- 登录卡片 -->
    <div class="login-card">
      <!-- 头像区域 -->
      <div class="avatar-box">
        <i class="el-icon-reading"></i>
      </div>

      <!-- 标题 -->
      <h2 class="login-title">欢迎回来</h2>
      <p class="login-subtitle">TJU网上书店</p>

      <!-- 登录表单 -->
      <el-form
        :model="form"
        :rules="rules"
        ref="loginForm"
        class="login-form"
      >
        <el-form-item prop="username">
          <el-input
            v-model="form.username"
            prefix-icon="el-icon-user"
            placeholder="请输入用户名"
            size="large"
          ></el-input>
        </el-form-item>

        <el-form-item prop="password">
          <el-input
            v-model="form.password"
            prefix-icon="el-icon-lock"
            placeholder="请输入密码"
            type="password"
            size="large"
            show-password
          ></el-input>
        </el-form-item>

        <el-form-item prop="validCode">
          <div class="code-row">
            <el-input
              v-model="form.validCode"
              prefix-icon="el-icon-key"
              placeholder="验证码"
              size="large"
              @keydown.enter.native="login"
            ></el-input>
            <ValidCode @input="getValidCode" ref="child" class="valid-code"></ValidCode>
          </div>
        </el-form-item>

        <el-form-item>
          <el-button
            type="primary"
            class="btn-login"
            @click="login"
            :loading="loading"
          >
            登 录
          </el-button>
        </el-form-item>

        <el-form-item>
          <div class="form-footer">
            <el-button type="text" @click="$router.push('/register')">
              <i class="el-icon-user"></i> 免费注册
            </el-button>
            <el-button type="text" @click="jump">
              <i class="el-icon-setting"></i> 管理员登录
            </el-button>
          </div>
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
  components: {
    ValidCode,
  },
  created() {
    document.title = '登录 - TJU网上书店';
  },
  data() {
    return {
      loading: false,
      form: {
        username: 'admin',
        password: '123'
      },
      validCode: "",
      rules: {
        username: [
          { required: true, message: "请输入用户名", trigger: "blur" },
          { min: 2, max: 25, message: "长度在 2 到 25 个字符", trigger: "blur" },
        ],
        password: [
          { required: true, message: "请输入密码", trigger: "blur" },
          { min: 1, max: 15, message: "长度在 1 到 15 个字符", trigger: "blur" },
        ],
        validCode: [
          { required: true, message: "请输入验证码", trigger: "blur" }
        ],
      },
    }
  },
  methods: {
    getValidCode(data) {
      this.validCode = data;
    },
    login() {
      this.$refs['loginForm'].validate((valid) => {
        if (valid) {
          if (this.form.validCode.toLowerCase() !== this.validCode.toLowerCase()) {
            this.$message.error('验证码错误');
            this.$refs.child.refreshCode();
            return;
          }
          this.loading = true;
          request.post('/user/login', this.form).then(res => {
            this.loading = false;
            if (res.code === '0') {
              this.$message.success("登录成功");
              sessionStorage.setItem("user", JSON.stringify(res.data));
              this.$router.push('/shop');
            } else {
              this.$message.error(res.msg);
            }
          }).catch(() => {
            this.loading = false;
          });
        }
      });
    },
    jump() {
      this.$router.push('/manageLogin');
    }
  }
}
</script>

<style lang="less" scoped>
.login-page {
  min-height: 100vh;
  background: linear-gradient(135deg, #ff7e5f 0%, #ff5000 50%, #feb47b 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  overflow: hidden;
}

/* 背景装饰 */
.bg-decoration {
  position: absolute;
  width: 100%;
  height: 100%;
  pointer-events: none;
}

.circle {
  position: absolute;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.1);
}

.circle-1 {
  width: 400px;
  height: 400px;
  top: -100px;
  left: -100px;
}

.circle-2 {
  width: 300px;
  height: 300px;
  bottom: -50px;
  right: -50px;
}

.circle-3 {
  width: 200px;
  height: 200px;
  top: 50%;
  right: 10%;
}

/* 登录卡片 */
.login-card {
  width: 420px;
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  border-radius: 16px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
  padding: 60px 40px 40px;
  position: relative;
  z-index: 10;
}

/* 头像 */
.avatar-box {
  width: 100px;
  height: 100px;
  border-radius: 50%;
  background: linear-gradient(135deg, #ff5000 0%, #ff7433 100%);
  box-shadow: 0 8px 24px rgba(255, 80, 0, 0.3);
  position: absolute;
  top: -50px;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  align-items: center;
  justify-content: center;
}

.avatar-box i {
  font-size: 48px;
  color: #fff;
}

/* 标题 */
.login-title {
  text-align: center;
  font-size: 24px;
  font-weight: 600;
  color: #333;
  margin: 20px 0 8px;
}

.login-subtitle {
  text-align: center;
  font-size: 14px;
  color: #999;
  margin: 0 0 30px;
}

/* 表单 */
.login-form {
  .el-form-item {
    margin-bottom: 20px;
  }

  .el-input {
    /deep/ .el-input__inner {
      height: 46px;
      border-radius: 8px;
      border: 2px solid #eee;
      padding-left: 44px;
      font-size: 14px;
      transition: all 0.25s ease;

      &:focus {
        border-color: #ff5000;
      }
    }

    /deep/ .el-input__prefix {
      left: 12px;
      color: #999;
    }
  }
}

.code-row {
  display: flex;
  gap: 12px;

  .el-input {
    flex: 1;
  }

  .valid-code {
    flex-shrink: 0;
  }
}

.btn-login {
  width: 100%;
  height: 46px;
  border-radius: 8px;
  font-size: 16px;
  font-weight: 500;
  background: linear-gradient(135deg, #ff5000 0%, #ff7433 100%);
  border: none;
  transition: all 0.25s ease;

  &:hover {
    background: linear-gradient(135deg, #e64500 0%, #ff5000 100%);
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(255, 80, 0, 0.3);
  }
}

.form-footer {
  display: flex;
  justify-content: space-between;
  margin-top: -10px;

  .el-button--text {
    color: #666;
    font-size: 13px;

    &:hover {
      color: #ff5000;
    }

    i {
      margin-right: 4px;
    }
  }
}
</style>
