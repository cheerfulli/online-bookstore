<template>
  <div style="margin: 50px 100px">
    <el-card class="box-card" style="width: 700px;height: 700px">
      <div slot="header" class="clearfix" align="center">
        <span>个人信息</span>
      </div>

<!--      头像选择区域-->
      <div style="width: 178px;height: 178px;margin-bottom: 20px;margin-left: 250px">
        <el-upload
            class="avatar-uploader"
            action="http://localhost:9090/files/upload"
            :show-file-list="false"
            :on-success="handleAvatarSuccess"
            :before-upload="beforeAvatarUpload">
          <img v-if="form.avatar" :src="form.avatar" class="avatar" alt="用户头像">
          <i v-else class="el-icon-plus avatar-uploader-icon"></i>
        </el-upload>
      </div>

      <el-form ref="form" :model="form" label-width="20%">
        <el-form-item label="用户名">
          <el-input v-model="form.username" disabled></el-input>
        </el-form-item>
        <el-form-item label="密码">
          <el-input v-model="form.password"></el-input>
        </el-form-item>
        <el-form-item label="昵称">
          <el-input v-model="form.nickName"></el-input>
        </el-form-item>
        <el-form-item label="年龄">
          <el-input v-model="form.age"></el-input>
        </el-form-item>
        <!--          绑定字符串不用：label，绑定数字就要用：label才行-->
        <el-form-item label="性别">
          <el-radio v-model="form.sex" label="男">男</el-radio>
          <el-radio v-model="form.sex" label="女">女</el-radio>
          <el-radio v-model="form.sex" label="未知">不告诉你</el-radio>
        </el-form-item>
        <el-form-item label="送货地址">
          <el-input v-model="form.address"></el-input>
        </el-form-item>
      </el-form>
      <el-button type="primary" style="float: right;margin: 20px" @click="save()">保存</el-button>
    </el-card>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "ProfileView",
  created() {
    document.title = "我的信息";
    // 取出session的字符串,为了防止取到空值，||一个空对象
    let str = sessionStorage.getItem('user') || '{}';
    // 赋值
    this.form = JSON.parse(str);
  },
  data(){
    return{
      form: {},
    }
  },
  methods: {
    save(){
      this.$confirm("确定要更新你的个人信息吗", "提示", {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        request.put('/user', this.form).then(res => {
          if (res.code === '0'){
            this.$message.success("更新成功");
            // 重置缓存里面的数据，缓存里面只能存储字符串，切记切记，不能直接传参数过去
            sessionStorage.setItem("user", JSON.stringify(this.form));
          }else {
            this.$message.error("更新失败")
          }
        })
      }).catch(() =>{
        this.$message({
          type: "info",
          message: "取消更改"
        })
      })
    },
    handleAvatarSuccess(res) {
      this.form.avatar = res.data;
    },
    beforeAvatarUpload(file) {
      const isJPG = file.type === 'image/jpeg';
      const isLt2M = file.size / 1024 / 1024 < 2;

      if (!isJPG) {
        this.$message.error('上传头像图片只能是 JPG 格式!');
      }
      if (!isLt2M) {
        this.$message.error('上传头像图片大小不能超过 2MB!');
      }
      return isJPG && isLt2M;
    }
  }
}
</script>

<style scoped>
.avatar-uploader{
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader:hover {
  border-color: #409EFF;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}
.avatar {
  width: 178px;
  height: 178px;
  display: block;
}
</style>