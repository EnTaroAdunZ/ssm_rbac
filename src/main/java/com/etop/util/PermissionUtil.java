package com.etop.util;

import com.etop.pojo.Permission;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;
import java.util.HashSet;

/**
 * Created by 63574 on 2017/7/14.
 */

@Component
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
