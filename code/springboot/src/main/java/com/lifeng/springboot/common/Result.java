package com.lifeng.springboot.common;

/**
 * 封装json数据传送给前端
 * @param <T> T代表封装的对象类型
 */
public class Result<T> {
    private String code;    //code代表事件的状态
    private String msg;   //msg代表事件信息
    private T data; //需要封装的信息

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public Result() {
    }

    public Result(T data) {
        this.data = data;
    }

    public static Result success(){
        Result result = new Result<>();
//        code=0表示成功
        result.setCode("0");
        result.setMsg("成功");
        return result;
    }

    public static <T> Result<T> success(T data){
        Result<T> result = new Result<>(data);
        result.setMsg("成功");
        result.setCode("0");
        return result;
    }

    public static Result error(String code,String msg){
        Result result = new Result();
        result.setCode(code);
        result.setMsg(msg);
        return result;
    }
}
