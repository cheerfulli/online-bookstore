package com.lifeng.springboot.common;

import java.lang.annotation.*;



@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface AuthAccess {
    String message() default "";
}
