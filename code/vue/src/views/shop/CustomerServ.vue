<template>
  <div class="customer-serv-page">
    <!-- 页面标题 -->
    <div class="page-header">
      <h2><i class="el-icon-service"></i> 意见反馈</h2>
      <p class="page-desc">您的建议是我们进步的动力</p>
    </div>

    <!-- 反馈表单 -->
    <div class="feedback-card">
      <el-form :model="form" label-position="top" class="feedback-form">
        <el-form-item label="建议主题" required>
          <el-input
            v-model="form.title"
            placeholder="请输入主题，如：功能建议、问题反馈等"
            maxlength="20"
            show-word-limit
            clearable
          >
            <template #prefix>
              <i class="el-icon-edit-outline"></i>
            </template>
          </el-input>
        </el-form-item>

        <el-form-item label="建议内容" required>
          <el-input
            type="textarea"
            v-model="form.content"
            placeholder="请详细描述您的建议或遇到的问题，我们会认真阅读每一条反馈..."
            :rows="10"
            maxlength="1000"
            show-word-limit
          ></el-input>
        </el-form-item>

        <el-form-item class="form-actions">
          <el-button type="primary" class="submit-btn" @click="submit">
            <i class="el-icon-position"></i> 提交反馈
          </el-button>
        </el-form-item>
      </el-form>

      <!-- 提示信息 -->
      <div class="tips-section">
        <h4><i class="el-icon-info"></i> 温馨提示</h4>
        <ul>
          <li>请尽量详细描述您的问题或建议</li>
          <li>我们会在1-3个工作日内处理您的反馈</li>
          <li>感谢您对TJU网上书店的支持</li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "CustomerServ",
  created() {
    document.title = "意见反馈 - TJU网上书店";
    let str = sessionStorage.getItem('user') || '{}';
    this.user = JSON.parse(str);
  },
  data() {
    return {
      user: {},
      form: {}
    }
  },
  methods: {
    submit() {
      if (!this.form.title) {
        this.$message.warning("请输入建议主题");
        return;
      }
      if (!this.form.content) {
        this.$message.warning("请输入建议内容");
        return;
      }

      this.$confirm('确定提交您的反馈吗？', '提交确认', {
        confirmButtonText: '确定提交',
        cancelButtonText: '取消',
        type: 'info'
      }).then(() => {
        this.form.userId = this.user.id;
        this.form.username = this.user.username;
        this.form.nickName = this.user.nickName;
        request.post('/customerServ', this.form).then(res => {
          if (res.code === '0') {
            this.form.title = "";
            this.form.content = "";
            this.$message.success("提交成功，感谢您的反馈！");
          } else {
            this.$message.error("提交失败，请稍后重试");
          }
        });
      }).catch(() => {});
    }
  }
}
</script>

<style scoped>
.customer-serv-page {
  padding: 24px;
  max-width: 800px;
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
  margin: 0 0 8px 0;
  display: flex;
  align-items: center;
  gap: 8px;
}

.page-header h2 i {
  color: var(--primary-color, #ff5000);
}

.page-desc {
  font-size: 14px;
  color: var(--text-secondary, #666);
  margin: 0;
}

/* 反馈卡片 */
.feedback-card {
  background: #fff;
  border-radius: var(--radius-lg, 12px);
  padding: 30px;
  box-shadow: var(--shadow-sm, 0 1px 2px rgba(0,0,0,0.06));
}

/* 表单样式 */
.feedback-form >>> .el-form-item__label {
  font-weight: 500;
  color: var(--text-primary, #333);
  padding-bottom: 8px;
}

.feedback-form >>> .el-input__inner {
  height: 44px;
  border-radius: var(--radius-md, 8px);
}

.feedback-form >>> .el-input__prefix {
  left: 12px;
  color: var(--text-placeholder, #999);
}

.feedback-form >>> .el-input--prefix .el-input__inner {
  padding-left: 36px;
}

.feedback-form >>> .el-textarea__inner {
  border-radius: var(--radius-md, 8px);
  padding: 12px 15px;
  line-height: 1.6;
  font-size: 14px;
}

.feedback-form >>> .el-textarea__inner:focus {
  border-color: var(--primary-color, #ff5000);
}

.feedback-form >>> .el-input__count {
  background: transparent;
  font-size: 12px;
  color: var(--text-placeholder, #999);
}

/* 提交按钮 */
.form-actions {
  margin-top: 24px;
  margin-bottom: 0;
}

.submit-btn {
  width: 100%;
  height: 48px;
  font-size: 16px;
  border-radius: var(--radius-md, 8px);
  background: linear-gradient(135deg, #ff5000 0%, #ff7433 100%);
  border: none;
}

.submit-btn:hover {
  background: linear-gradient(135deg, #e64500 0%, #ff5000 100%);
}

.submit-btn i {
  margin-right: 6px;
}

/* 提示信息 */
.tips-section {
  margin-top: 30px;
  padding-top: 24px;
  border-top: 1px dashed var(--border-color, #e8e8e8);
}

.tips-section h4 {
  font-size: 14px;
  font-weight: 500;
  color: var(--text-secondary, #666);
  margin: 0 0 12px 0;
  display: flex;
  align-items: center;
  gap: 6px;
}

.tips-section h4 i {
  color: var(--info-color, #1890ff);
}

.tips-section ul {
  margin: 0;
  padding-left: 20px;
}

.tips-section li {
  font-size: 13px;
  color: var(--text-placeholder, #999);
  line-height: 2;
}
</style>