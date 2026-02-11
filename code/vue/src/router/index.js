import Vue from 'vue'
import VueRouter from 'vue-router'
import UserView from '../views/manage/UserView.vue'
import Layout from "@/layout/Layout.vue";
import ShopView from "@/views/shop/ShopView.vue";
import MyLayout from "@/layout/MyLayout.vue";
import ShoppingCart from "@/views/shop/ShoppingCart.vue";
import MyOrder from "@/views/shop/MyOrder.vue";
import Login from "@/views/Login.vue";
import LoginView from "@/views/LoginView.vue";
import AdviceView from "@/views/manage/AdviceView.vue";
import RefundOrderView from "@/views/manage/RefundOrderView.vue";
import AddressManage from "@/views/shop/AddressManage.vue";

Vue.use(VueRouter)

const routes = [
    //   管理路由
    {
        //当一个框架有默认的子路由的时候就不需要名称，将子路由写为'/'就可以了
        path: '/home',
        component: Layout,
        // 管理子路由
        children: [
            {path: '/', alias: '/user', name: 'user', component: UserView,},
            // 如果采取全局的 import 函数，就是加载的时候就会全部加载完，然后这种匿名函数导入的方法就可以使用到再导入
            {path: '/person', name: 'person', component: () => import("@/views/manage/PersonView.vue")},
            {path: '/item', name: 'item', component: () => import("@/views/manage/ItemView.vue")},
            {path: '/order', name: "order", component: () => import("@/views/manage/OrderView.vue")},
            {path: '/description', name: "description", component: () => import("@/views/manage/Description.vue")},
            {path: '/advice', name: "advice", component: AdviceView},
            {path: '/refund', name: "refund", component: RefundOrderView},
            {path: '/charts', name: "charts", component: () => import("@/views/manage/Charts.vue")},
        ]
    },
    // 驾驶舱路由
    {
        path: '/myCharts',
        name: 'myCharts',
        component: () => import("@/views/manage/MyCharts.vue")
    },
    //   登录路由
    {
        path: '/',
        alias: '/login',
        name: 'Login',
        component: Login,
    },
    // 管理员登录路由
    {
      path: '/manageLogin',
      name: 'ManageLogin',
      component: LoginView,
    },
    //   注册路由
    {
        path: '/register',
        name: 'Register',
        component: () => import('@/views/Register.vue')
    },
    //   商城路由
    {
        path: '/shop',
        component: () => import('@/layout/ShopLayout.vue'),
        // 商城子路由
        children: [
            {path: '/', name: 'shop', component: ShopView,},
            {path: '/shop/detail', name: 'detail', component: () => import('@/views/shop/Detail.vue')},
            // 我的淘宝子路由
            {
                path: '/mine',
                component: MyLayout,
                children: [
                    {path: '/', name: 'profile', component: () => import("@/views/shop/ProfileView.vue")},
                    {path: '/cart', name: 'ShoppingCart', component: ShoppingCart},
                    {path: '/myOrder', name: "myOrderView", component: MyOrder},
                    {path: '/customerServ', name: 'customerService', component: () => import("@/views/shop/CustomerServ.vue")},
                    {path: '/addressManage', component: AddressManage},
                ]
            }
        ]
    },
    {path: '/*', component: () => import("@/views/404.vue")}
]

const router = new VueRouter({
    mode: 'history',
    base: process.env.BASE_URL,
    routes
})

export default router
