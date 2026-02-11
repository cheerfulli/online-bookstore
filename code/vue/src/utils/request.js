import axios from "axios";
import router from "@/router";

const request = axios.create({
    // 注意！！ 这里是全局统一加上了 '/api' 前缀，也就是说所有接口都会加上'/api'前缀.
    // 页面里面写接口的时候就不要加 '/api'了，否则会出现2个'/api'，类似 '/api/api/user'这样的报错，切记！！！
    baseURL: '/api',
    timeout: 5000
});

// request 请求拦截器
// 可以自请求发送前对请求做一些处理
// 比如统一加token，对请求参数统一加密
request.interceptors.request.use(config => {
    // 设置请求头
    config.headers['Content-Type'] = 'application/json;charset=utf-8';

    // 这里是发送了请求之后才拦截，如果访问的是静态页面，不发送请求那种就不会拦截，比如空的Person
    // 查看有没有登录，没有登录返回登录页面
    let user = JSON.parse(sessionStorage.getItem("user")) || {};

    // 添加token
    config.headers['Authorization'] = user.token;

    return config;
},error => {
    return Promise.reject(error);
});

// response 应答拦截器
// 可以在接口响应后统一处理结果
request.interceptors.response.use(
    response => {
        let res = response.data;
        // 如果返回的是文件
        if (response.config.responseType === 'blob'){
            return res;
        }
        // 兼容服务端返回的字符串数据
        if (typeof res === 'string'){
            res = res ? JSON.parse(res) : res
        }
        // 如果没有权限，也就是code401，就跳转到登录页
        if (res.code === '401'){
            router.push('/login').then(() =>{
                alert("权限校验不合法：" + res.msg)
            })
            return
        }
        return res;
    },
    error => {
        // for debug
        console.log("返回发生错误",error);
        return Promise.reject(error);
    }
);

export default request;