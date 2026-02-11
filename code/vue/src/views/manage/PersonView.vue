<template>
  <div style="margin: 50px">
    <el-card class="box-card" style="margin: 20px;background-color: beige">
      <div slot="header" class="clearfix" align="center">
        <span>个人信息</span>
      </div>
      <el-form ref="form" :model="form" label-width="15%">
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
        <el-form-item label="地址">
          <el-input v-model="form.address"></el-input>
        </el-form-item>
      </el-form>
      <el-button type="primary" style="float: right;margin: 20px" @click="update()">保存</el-button>
    </el-card>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "PersonView",
  data(){
    return{
      form:{},
    }
  },
  created() {
    document.title = '个人信息';
    // 取出session的字符串,为了防止取到空值，||一个空对象
    let str = sessionStorage.getItem('user') || '{}';
    // 赋值
    this.form = JSON.parse(str);
  },
  methods: {
    update(){
      this.$confirm('确定要修改\"'+this.form.username+"\"的数据吗", "提示", {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        request.put('/user', this.form).then(res => {
          if (res.code === '0'){
            this.$message({
              type: "success",
              message: "修改成功！"
            });
            // 重置缓存里面的数据，缓存里面只能存储字符串，切记切记，不能直接传参数过去
            sessionStorage.setItem("user", JSON.stringify(this.form));
          }else {
            this.$message({
              type: "error",
              message: res.msg,
            })
          }
        })
      }).catch(() =>{
        this.$message({
          type: "info",
          message: "取消更改"
        })
      })
    }
  }
}
</script>

<style scoped>
.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}
.clearfix:after {
  clear: both
}

.box-card {
  width: 480px;
}
</style>