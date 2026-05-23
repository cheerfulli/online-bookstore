<template>
  <div class="profile-page">
    <!-- 页面标题 -->
    <div class="page-header">
      <h2><i class="el-icon-user"></i> 个人信息</h2>
    </div>

    <div class="profile-content">
      <!-- 头像区域 -->
      <div class="avatar-section">
        <el-upload
          class="avatar-uploader"
          action=""
          :show-file-list="false"
          :http-request="uploadAvatar"
          :before-upload="beforeAvatarUpload"
        >
          <img v-if="form.avatar" :src="form.avatar" class="avatar" alt="用户头像">
          <div v-else class="avatar-placeholder">
            <i class="el-icon-plus"></i>
            <span>上传头像</span>
          </div>
        </el-upload>
        <p class="avatar-tip">点击上传头像，支持 JPG 格式，不超过 2MB</p>
      </div>

      <!-- 表单区域 -->
      <div class="form-section">
        <el-form ref="form" :model="form" label-width="100px" class="profile-form">
          <el-form-item label="用户名">
            <el-input v-model="form.username" disabled>
              <template #prefix>
                <i class="el-icon-user"></i>
              </template>
            </el-input>
          </el-form-item>

          <el-form-item label="密码">
            <el-input v-model="form.password" type="password" show-password placeholder="请输入新密码">
              <template #prefix>
                <i class="el-icon-lock"></i>
              </template>
            </el-input>
          </el-form-item>

          <el-form-item label="昵称">
            <el-input v-model="form.nickName" placeholder="请输入昵称">
              <template #prefix>
                <i class="el-icon-postcard"></i>
              </template>
            </el-input>
          </el-form-item>

          <el-form-item label="年龄">
            <el-input v-model="form.age" type="number" placeholder="请输入年龄">
              <template #prefix>
                <i class="el-icon-date"></i>
              </template>
            </el-input>
          </el-form-item>

          <el-form-item label="性别">
            <el-radio-group v-model="form.sex" class="sex-radio">
              <el-radio label="男">
                <i class="el-icon-male"></i> 男
              </el-radio>
              <el-radio label="女">
                <i class="el-icon-female"></i> 女
              </el-radio>
              <el-radio label="未知">保密</el-radio>
            </el-radio-group>
          </el-form-item>

          <el-form-item label="收货地址">
            <el-input v-model="form.address" placeholder="请输入收货地址">
              <template #prefix>
                <i class="el-icon-location-outline"></i>
              </template>
            </el-input>
          </el-form-item>

          <el-form-item class="form-actions">
            <el-button type="primary" class="save-btn" @click="save">
              <i class="el-icon-check"></i> 保存修改
            </el-button>
          </el-form-item>
        </el-form>
      </div>
    </div>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "ProfileView",
  created() {
    document.title = "个人信息 - TJU网上书店";
    let str = sessionStorage.getItem('user') || '{}';
    this.form = JSON.parse(str);
  },
  data() {
    return {
      form: {},
    }
  },
  methods: {
    save() {
      this.$confirm("确定要更新个人信息吗？", "保存确认", {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'info'
      }).then(() => {
        request.put('/user', this.form).then(res => {
          if (res.code === '0') {
            this.$message.success("更新成功");
            sessionStorage.setItem("user", JSON.stringify(this.form));
          } else {
            this.$message.error("更新失败");
          }
        });
      }).catch(() => {});
    },
    handleAvatarSuccess(res) {
      this.form.avatar = res.data;
    },
    uploadAvatar(param) {
      const formData = new FormData();
      formData.append('file', param.file);
      request.post('/files/upload', formData, {
        headers: { 'Content-Type': 'multipart/form-data' }
      }).then(res => {
        if (res.code === '0') {
          this.handleAvatarSuccess(res);
          this.$message.success('头像上传成功');
        } else {
          this.$message.error(res.msg || '上传失败');
        }
      }).catch(() => {
        this.$message.error('上传失败');
      });
    },
    beforeAvatarUpload(file) {
      const isJPG = file.type === 'image/jpeg';
      const isPNG = file.type === 'image/png';
      const isLt2M = file.size / 1024 / 1024 < 2;

      if (!isJPG && !isPNG) {
        this.$message.error('上传头像只支持 JPG/PNG 格式');
        return false;
      }
      if (!isLt2M) {
        this.$message.error('上传头像大小不能超过 2MB');
        return false;
      }
      return true;
    }
  }
}
</script>

<style scoped>
.profile-page {
  padding: 24px;
}

/* 页面标题 */
.page-header {
  margin-bottom: 24px;
  padding-bottom: 16px;
  border-bottom: 1px solid var(--border-color, #e8e8e8);
}

.page-header h2 {
  font-size: 20px;
  font-weight: 600;
  color: var(--text-primary, #333);
  margin: 0;
  display: flex;
  align-items: center;
  gap: 8px;
}

.page-header h2 i {
  color: var(--primary-color, #ff5000);
}

/* 内容区域 */
.profile-content {
  max-width: 600px;
}

/* 头像区域 */
.avatar-section {
  text-align: center;
  margin-bottom: 32px;
}

.avatar-uploader {
  display: inline-block;
  width: 120px;
  height: 120px;
  border: 2px dashed var(--border-color, #e8e8e8);
  border-radius: 50%;
  cursor: pointer;
  overflow: hidden;
  transition: all 0.25s ease;
}

.avatar-uploader:hover {
  border-color: var(--primary-color, #ff5000);
}

.avatar {
  width: 120px;
  height: 120px;
  display: block;
  object-fit: cover;
}

.avatar-placeholder {
  width: 120px;
  height: 120px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: var(--text-placeholder, #999);
  background: #fafafa;
}

.avatar-placeholder i {
  font-size: 28px;
  margin-bottom: 4px;
}

.avatar-placeholder span {
  font-size: 12px;
}

.avatar-tip {
  font-size: 12px;
  color: var(--text-placeholder, #999);
  margin-top: 12px;
}

/* 表单区域 */
.form-section {
  background: #fff;
}

.profile-form .el-form-item {
  margin-bottom: 20px;
}

.profile-form >>> .el-input__inner {
  height: 42px;
  border-radius: var(--radius-md, 8px);
}

.profile-form >>> .el-input__prefix {
  left: 12px;
  color: var(--text-placeholder, #999);
}

.profile-form >>> .el-input--prefix .el-input__inner {
  padding-left: 36px;
}

.sex-radio {
  height: 42px;
  display: flex;
  align-items: center;
}

.sex-radio >>> .el-radio {
  margin-right: 24px;
}

.sex-radio >>> .el-radio__label {
  display: inline-flex;
  align-items: center;
  gap: 4px;
}

/* 保存按钮 */
.form-actions {
  margin-top: 32px;
  padding-top: 20px;
  border-top: 1px solid var(--border-color, #e8e8e8);
}

.save-btn {
  width: 100%;
  height: 44px;
  font-size: 15px;
  border-radius: var(--radius-md, 8px);
  background: linear-gradient(135deg, #ff5000 0%, #ff7433 100%);
  border: none;
}

.save-btn:hover {
  background: linear-gradient(135deg, #e64500 0%, #ff5000 100%);
}
</style>
