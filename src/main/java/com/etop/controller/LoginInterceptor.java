package com.etop.controller;

import com.etop.pojo.Msg;
import com.etop.util.RequiredPermission;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.InternalPathMethodNameResolver;
import org.springframework.web.servlet.mvc.multiaction.MethodNameResolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Method;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by 63574 on 2017/7/14.
 */
public class LoginInterceptor implements HandlerInterceptor {



    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        String url = httpServletRequest.getRequestURI();
        if(url.indexOf("login")>=0||url.indexOf("index")>=0){
            return true;
        }
        //ID为空
        HttpSession session=httpServletRequest.getSession();
        Long id = (Long) session.getAttribute("id");
        if(id==null){
            httpServletRequest.getRequestDispatcher("/login").forward(httpServletRequest,httpServletResponse);

            return false;
        }

        String controllerName = "";
        if(o instanceof  HandlerMethod ){
            Method method = ((HandlerMethod) o).getMethod();
            StringBuilder sb=new StringBuilder(50)
                    .append(method.getDeclaringClass().getCanonicalName())
                    .append("."+method.getName());
            HashSet<String> userPermission = (HashSet<String>) session.getAttribute("userPermission");
            if(method.isAnnotationPresent(RequiredPermission.class))
            if(userPermission==null||!userPermission.contains(sb.toString())){

                    httpServletRequest.getRequestDispatcher("/notpermission").forward(httpServletRequest,httpServletResponse);
                    return  false;

            }
        }
        return  true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
