<template>
  <div>


    <div class="headNav">
    <div class="content">
      <div style="float: left">
        <div style="width: 232px; height: 30px;vertical-align: middle;font-family: 宋体;font-size: 28px;font-style: italic">
          天大书店
        </div>
      </div>
      <div style="float: right">
        <el-input @keydown.enter.native="loadData" v-model="search" placeholder="请输入书籍关键词"  class="input-with-select" style="width: 400px;height: 30px;">
        </el-input>
        <el-button icon="el-icon-search" @click="loadData"></el-button>
      </div>
    </div>
    </div>

    <div style="padding-left: 50px; padding-right: 50px;padding-top: 20px; padding-bottom: 10px; background-color: rgb(248, 244, 244); ">
      <el-carousel indicator-position="outside"   style="width:100%">
      <el-carousel-item v-for="item in imgArray" :key="item">
        <img :src="item" class="rightImg">
      </el-carousel-item>
      </el-carousel>
    </div>

    <!--    下面的卡片视图-->
    <div style="background-color: white;margin: 0 50px">
      <el-row>
        <el-col :span="5" v-for="item in itemData" :key="item.id" :offset="1" style="margin-top: 10px;">
          <!--        用a标签包裹的卡片装商品，给href绑定动态地址-->
          <a :href="'/shop/detail?id='+item.id">
            <el-card :body-style="{ padding: '5px'}">
              <img :src="item.image?item.image:hamburgUrl"
                   class="image" alt="缺少图片">
              <div style="padding: 10px; ">
                <span class="title">{{ item.title }}</span>
                <div class="info-wrapper">
                  <div class="sellPoint">{{ item.sellPoint }}</div>
                  <div><i class="el-icon-s-goods" style="float: right;color: rgba(255,80,24);font-size: 20px">
                    ￥:{{ item.price }}</i></div>
                </div>
              </div>
            </el-card>
          </a>
        </el-col>
      </el-row>
    </div>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "ShopView",
  data() {
    return {
      // 查询的关键词
      search: '',
      // 收到的商品数据
      itemData: [],
      //汉堡Url
      hamburgUrl: "https://shadow.elemecdn.com/app/element/hamburger.9cf7b091-55e9-11e9-a976-7f4d0b07eef6.png",
      imgArray: [
        require('@/assets/images/pc1.jpg'),
        require('@/assets/images/pc2.jpg'),
        require('@/assets/images/pc3.jpg'),
        require('@/assets/images/pc4.jpg')
      ]
    };
  },
  created() {
    this.loadData();
    document.title = "book-Shop"
  },
  methods: {
    loadData() {
      request.get('/item/getAll',{
        params: {
          search: this.search,
        }
      }).then(res => {
        this.itemData = res.data;
      })
    }
  }
}
</script>

<style scoped>
.title{
  font-size: 15px;
}
.title:hover{
  color: #ff5000;
}
.info-wrapper .sellPoint {
  display: inline-block;
  height: 46px;
  margin: 6px 0 2px 0;
  overflow: hidden;
  color: #333;
  font-size: 10px;
  line-height: 23px;
}

.info-wrapper .sellPoint:hover {
  color: #ff5000;
}

.image {
  width: 100%;
  height: 223px;
}

.topLogs {
  margin-left: 200px;
  margin-top: -30px;
  float: left;
}

.topLogs img {
  width: 200px;
  height: 72px;
}

.headNav{
    width: 100%;
    background-color: #f2f1ea;
    line-height: 70px;
    clear: both;
  }
  .content{
    margin: 0px auto;
    width: 1240px;
    height: 70px;
    background-color: #f2f1ea;
  }
  .el-select {
    width: 110px;
  }

  .rightImg {
  width: 100%;
  height: 540px;
}
  .el-carousel__item h3 {
    color: #475669;
    font-size: 18px;
    opacity: 0.75;
    line-height: 300px;
    margin: 0;
  }
  
  .el-carousel__item:nth-child(2n) {
    background-color: #99a9bf;
  }
  
  .el-carousel__item:nth-child(2n+1) {
    background-color: #d3dce6;
  }
</style>