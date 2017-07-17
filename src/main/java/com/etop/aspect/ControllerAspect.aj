package com.etop.aspect;


import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;


/**
 * Created by 63574 on 2017/7/15.
 */

@Aspect
@Component
public class  ControllerAspect {

    @Pointcut("execution(* com.etop.controller.*.*(..))")
    private void anyMethod(){}//定义一个切入点

    @Around("anyMethod()")
    public Object log(ProceedingJoinPoint joinPoint) throws Throwable {
        System.out.println("start log:" + joinPoint.getSignature().getName());
        Object object = joinPoint.proceed();
        System.out.println("end log:" + joinPoint.getSignature().getName());
        return object;
    }
}
