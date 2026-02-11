<template>
  <div style="background-color: white;margin: 10px 200px;flex: auto;height: auto">
    <!--    图片和详情框-->
    <div style="padding: 50px">
      <!--      图片的位置-->
      <el-image
          style="width: 400px; height: 407px;"
          :src="itemData.image"
          :preview-src-list="[itemData.image]">
      </el-image>
      <!--      详情框-->
      <div class="recommend">
        <div style="float: right;width: 600px">
          <h3  style="margin: 20px 0">{{ itemData.sellPoint }}</h3>
          <el-descriptions title="" :column="1" border>
            <el-descriptions-item label="价格" :label-style=labelStyle :contentStyle=rowStyle_price>¥{{itemData.price}}</el-descriptions-item>
            <el-descriptions-item label="配送地址" :label-style=labelStyle :contentStyle=rowStyle>{{ user.address }}</el-descriptions-item>
            <el-descriptions-item label="库存" :label-style=labelStyle :contentStyle=rowStyle>{{ itemData.stock }}</el-descriptions-item>
            <el-descriptions-item label="承诺" :label-style=labelStyle :contentStyle=rowStyle>七天无理由，包邮</el-descriptions-item>
            <el-descriptions-item label="购买数量" :label-style=labelStyle :contentStyle=rowStyle>
              <el-input-number v-model="num" @change="handleChange" :min=1 label="请选择购买的数量"></el-input-number>
            </el-descriptions-item>
          </el-descriptions>
        </div>
      </div>
    </div>
    <!--  这里是按钮栏-->
    <div style="padding: 50px 0;margin: 0 50px;background-color: rgba(255,242,204)">
      <el-row>
        <el-col :span="12" align="center"><el-button icon="el-icon-s-goods" class="my-button" @click="addCart">加入购物车</el-button></el-col>
        <el-col :span="12" align="center">
          <el-button icon="el-icon-check" type="danger" class="my-button" @click="buy">立即购买</el-button>
        </el-col>
      </el-row>
    </div>
    <!--    商品详情部分-->
    <div class="price-info">
      <div class="container">
        <h2 style="margin: 20px 0;color: #d71d3f">商品详情</h2>
        <div class="desc" v-html="proUrl">
        </div>

      </div>
    </div>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "Detail",
  created() {
    // 取出当前点击的商品ID
    // console.log("当前查询的ID是"+this.$route.query.id);
    this.loadData(this.$route.query.id);
    // 从session中取出登陆者的信息
    let str = sessionStorage.getItem("user") || "{}";
    // 解析str
    this.user = JSON.parse(str);
    // console.log("现在登录的人是"+this.user.username);
  },
  data(){
    return{
      // 商品详情的HTML
      proUrl: "",
      // 购买者的信息
      user: {},
      // 商品的信息
      itemData:{
      },
      // 购买的数量
      num: 1,
      // 描述内容样式
      rowStyle: {
        'text-align': 'center',
        'height': '65px',
        'font-size': '15px',
        'background': '#FDE2E2',
      },
      // 描述标签样式
      labelStyle:{
        'text-align': 'center',
        'font-size': '15px',
        'background': '#E1F3D8',
      },
      // 价格标红
      rowStyle_price: {
        'text-align': 'center',
        'height': '65px',
        'font-size': '25px',
        'background': '#FDE2E2',
        'color': 'rgba(255,68,0)'
      },
    }
  },
  methods: {
    loadData:function (id){
      // 加载商品数据
      request.get('/item/one',{
        params:{
          id: id,
        }
      }).then(res => {
        // console.log(res);
        this.itemData = res.data;
        document.title = this.itemData.title;
      });
      // 加载详情数据
      request.get("/itemDetail",{
        params: {
          id: id,
        }
      }).then(res => {
        this.proUrl = res.data.itemDetail;
      });
    },
    buy() {
      request.get("/order/buy",{
        params:{
          itemId: this.itemData.id,
          userId: this.user.id,
          count: this.num
        }
      }).then(res => {
        this.$message.success("即将进入支付页面~~~");
        // 直接通过返回的链接打开新窗口
        alert("即将进入支付页面，请注意支付环境安全")
        window.open(res.data);
      })
    },
    handleChange(){
    },
    addCart(){
      this.$confirm('是否确定加入购物车?', '==================', {
        confirmButtonText: 'Yes',
        cancelButtonText: 'No',
        type: 'warning'
      }).
      then(() => {
        request.get('/cart/add',{
          params: {
            itemId: this.itemData.id,
            userId: this.user.id,
            count: this.num
          }
        }).
        then(res => {
          this.$message.success("加入购物车成功~");
        });
      }).
      catch(() => {
        this.$message({
          type: 'error',
          message: '取消加入购物车'
        });
      });
    }
  }
}
</script>

<style scoped>
.recommend{
  float: right;
  background-color: rgba(255,242,232);
}
.my-button{
  height: 70px;
  width: 200px;
  font-size: 25px;
  border-radius: 4px;
  color: white;
  background-color: rgba(255,68,0);
}

.price-info {
  text-align: center;
  background-color: #f3f3f3;
  height: auto;
  margin: 50px;

h2 {
  font-size: 24px;
  color: #333333;
  padding-top: 38px;
  margin-bottom: 30px;
  border-bottom: coral 2px solid;
  line-height: 50px;
}

.attributes-list {
  width: 749px;
  display: block;
  clear: both;
  margin: 20px auto;
  min-height: 50px;
  text-align: left;

li {
  display: inline;
  float: left;
  width: 206px;
  height: 24px;
  margin-right: 20px;
  overflow: hidden;
  text-indent: 5px;
  line-height: 24px;
  white-space: nowrap;
  text-overflow: ellipsis;
}
}
}


</style>