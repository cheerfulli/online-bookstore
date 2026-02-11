// 跨域配置
module.exports = {
    devServer: {
        // 记住，别写错了devServer
        // 这里是给前端项目设置一个端口，设置本地默认端口  选填
        port: 9876,
        // 设置代理，必须写,其实就是拦截前缀为’/api‘的请求，然后转换成target，因为好像浏览器不允许跨域，所以要骗过浏览器
        proxy: {
            // 设置拦截器 拦截器格式： 斜杠+拦截器名字，名字可以自己定
            '/api': {
                // 代理的目标地址
                target: 'http://localhost:9090/',
                // 是否设置同源
                changeOrigin: true,
                // 路径重写
                pathRewrite: {
                    //选择忽略拦截器里面的内容
                    '^/api': ''
                }
            }
        }
    }
}