package com.lifeng.springboot.controller;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSON;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import com.lifeng.springboot.common.AliOssUtil;
import com.lifeng.springboot.common.Result;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

//设置跨域
@CrossOrigin
@RestController
@RequestMapping("/files")
public class FileController {

    @Value("${server.port}")
    private String port;

    private static final String ip = "http://localhost";

    private AliOssUtil aliOssUtil;
    @PostMapping("/upload")
    public Result<?> upload(MultipartFile file) throws IOException {
        // 定义文件的唯一标识
        String flag = IdUtil.fastSimpleUUID();
        // 获取文件的文件名
        String originalFilename = file.getOriginalFilename();
        //        拼接总的文件名
        String fileName = flag + "_" + originalFilename;
        // 获取上传的路径
        String rootFilePath = System.getProperty("user.dir") + "/src/main/resources/files/" + fileName;
        // 将文件写入你的路径
        FileUtil.writeBytes(file.getBytes(), rootFilePath);
        // 返回文件的URL
        return Result.success(ip + ":" + port + "/files/" + fileName);
    }

//    @PostMapping("/upload")
//    public Result<?> upload(MultipartFile file){
//        try {
//            String originalFilename = file.getOriginalFilename();
//            String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
//            String url = aliOssUtil.upload(file.getBytes(), UUID.randomUUID().toString() + extension);
//            return Result.success(url);
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//        return Result.error("-1","上传失败");
//    }

    @PostMapping("/editor/upload")
    public JSON editorUpload(MultipartFile file) throws IOException {
//        String originalFilename = file.getOriginalFilename();
//        String flag = IdUtil.fastSimpleUUID();
//        String rootFilePath = System.getProperty("user.dir") + "c/main/resources/files/" + flag + "_" + originalFilename;
//        FileUtil.writeBytes(file.getBytes(), rootFilePath);
//        String url=ip + ":" + port + "/files/" + flag;
//        JSONObject json=new JSONObject();
//        json.set("errno",0);
//        JSONArray arr=new JSONArray();
//        JSONObject data=new JSONObject();
//        arr.add(data);
//        data.set("url",url);
//        json.set("data",arr);
//        return json;
        // 定义文件的唯一标识
        String flag = IdUtil.fastSimpleUUID();
        // 获取文件的文件名
        String originalFilename = file.getOriginalFilename();
        //        拼接总的文件名
        String fileName = flag + "_" + originalFilename;
        // 获取上传的路径
        String rootFilePath = System.getProperty("user.dir") + "/src/main/resources/files/" + fileName;
        // 将文件写入你的路径
        FileUtil.writeBytes(file.getBytes(), rootFilePath);
        String url=ip+":"+port+"/files/"+fileName;
        JSONObject json=new JSONObject();
        json.set("errno",0);
        JSONArray arr=new JSONArray();
        JSONObject data=new JSONObject();
        arr.add(data);
        data.set("url",url);
        json.set("data",arr);
        return json;
    }

    /**
     * 前端使用src标签绑定一个图片的时候就会使用到Get方法预览到网页上，注释掉这个方法就会无法预览
     * 和青戈的不一样，因为上面文件上传的返回值就是一个准确的文件名，所以这里就不用再模糊搜索，直接返回对应的图片就可以了
     *
     * @param flag     图片的标识
     * @param response 回复流
     */
    @GetMapping("/{flag}")
    public void getFiles(@PathVariable String flag, HttpServletResponse response) {
        // 新建一个输出流
        OutputStream os;
//        导出路径
        String basePath = System.getProperty("user.dir") + "/src/main/resources/files/";
//        找到所有的文件
//        List<String> fileNames = FileUtil.listFileNames(basePath);
//        找到对应的文件
//        String filename = fileNames.stream().filter(name -> name.contains(flag)).findAny().orElse("");

        try {

            if (StrUtil.isNotEmpty(flag)) {
                response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(flag, StandardCharsets.UTF_8));
                response.setContentType("application/octet-stream");
                byte[] bytes = FileUtil.readBytes(basePath + flag);
                os = response.getOutputStream();
                os.write(bytes);
                os.flush();
                os.close();
            }
        } catch (Exception e) {
            System.out.println("文件下载失败");
        }
    }
}
