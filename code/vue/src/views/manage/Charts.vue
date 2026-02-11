<template>
  <div style="padding: 10px">
    <el-row :gutter="8">
      <!-- 一共24行-->
      <el-col :span="24">
        <el-card class="container" id="line"></el-card>
      </el-col>
    </el-row>

    <el-row :gutter="8" style="margin-top: 10px">
      <!-- 一共24行-->
      <el-col :span="24">
        <el-card class="container" id="bar"></el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import * as echarts from 'echarts'
import request from "@/utils/request";

let option = {
  title: {
    text: '订单金额趋势',
    left: 'center'
  },
  tooltip: {
    trigger: 'axis'
  },
  xAxis: {
    type: 'category',
    data: []
  },
  yAxis: {
    type: 'value',
    name: '金额',
  },
  series: [
    {
      name: '金额',
      data: [],
      type: 'line'
    }
  ]
};

let option2 = {
  title: {
    text: '订单数量趋势',
    left: 'center'
  },
  tooltip: {
    trigger: 'axis'
  },
  xAxis: {
    type: 'category',
    data: []
  },
  yAxis: {
    type: 'value',
    name: '销量'
  },
  series: [
    {
      name: '今日下单数',
      data: [],
      type: 'line',
      smooth: true
    },
    {
      data: [],
      type: 'bar'
    }
  ]
};

export default {
  name: "Charts",
  created() {
    document.title = '商城驾驶舱'
  },
  methods:{
  },
  // 等页面 DOM 渲染完毕，不然拿不到 line 容器
  mounted() {
    // 初始化表格
    let lineDom = document.getElementById('line')
    let lineChart = echarts.init(lineDom)
    let barDom = document.getElementById('bar')
    let barChart = echarts.init(barDom)
    request.get('order/charts').then(res => {
      // 渲染折线图
      option.xAxis.data = res.data.lineData.map(v => v.date) || []
      option.series[0].data = res.data?.lineData.map(v => v.value) || []
      lineChart.setOption(option)
      // 渲染柱状图
      option2.xAxis.data = res.data.barData.map(v => v.date) || []
      option2.series[0].data = res.data.barData.map(v => v.count) || []
      option2.series[1].data = option2.series[0].data
      barChart.setOption(option2)
    })
  }
}
</script>

<style scoped>
.container{
  padding: 20px;
  width: 100%;
  height: 400px;
}
</style>