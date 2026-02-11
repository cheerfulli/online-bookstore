<template>
  <div style="margin: 50px 100px">
    <el-card class="box-card" style="width: 700px;height: 700px">
      <el-tag effect="plain" style="font-size: 15px;margin: 20px 0">建议主题：</el-tag>
      <el-input
          type="text"
          placeholder="请输入主题"
          v-model="form.title"
          maxlength="20"
          show-word-limit
          style="font-size: 15px"
      >
      </el-input>
      <el-tag effect="plain" style="font-size: 15px;margin: 50px 0 20px 0">建议内容：</el-tag>
      <el-input
          type="textarea"
          placeholder="请发表你宝贵的建议吧~~~"
          v-model="form.content"
          rows="15"
          maxlength="1000"
          show-word-limit
          style="font-size: 15px">
      </el-input>

      <el-button type="primary" style="font-size: 15px;width: 150px;margin: 30px 250px" @click="submit()">提交</el-button>
    </el-card>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "CustomerServ",
  created() {
    document.title = "客服服务";
    // 取出session的字符串,为了防止取到空值，||一个空对象
    let str = sessionStorage.getItem('user') || '{}';
    // 赋值
    this.user = JSON.parse(str);
  },
  data(){
    return{
      user:{},
      form:{}
    }
  },
  methods: {
    submit(){
      this.$confirm('确定填写完成了吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.form.userId = this.user.id;
        this.form.username = this.user.username;
        this.form.nickName = this.user.nickName;
        request.post('/customerServ',this.form).then(res => {
          if (res.code === '0') {
            // 清空表格
            this.form.title = "";
            this.form.content = "";
            this.$message.success("提交成功");
          }else {
            this.$message.error("提交失败")
          }
        })
      });
    }
  }
}
</script>

<style scoped>
</style>