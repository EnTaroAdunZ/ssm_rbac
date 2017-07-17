package com.etop.util;

import com.etop.pojo.Permission;

import java.lang.reflect.Method;

/**
 * Created by 63574 on 2017/7/14.
 */
public class PermissionUtil {
    public static Permission methodToPermission(Method method){
        StringBuilder sb=new StringBuilder(50)
                .append(method.getDeclaringClass().getCanonicalName())
                .append("."+method.getName());
        String value = method.getAnnotation(RequiredPermission.class).value();
        Permission permission = new Permission(sb.toString(),value);
        return permission;
    }
}
