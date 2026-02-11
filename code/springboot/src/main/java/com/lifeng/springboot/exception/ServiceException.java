package com.lifeng.springboot.exception;

import lombok.Getter;



@Getter
public class ServiceException extends RuntimeException {
    private final String code;

    public ServiceException(String code, String msg) {
        super(msg);
        this.code = code;
    }
}
