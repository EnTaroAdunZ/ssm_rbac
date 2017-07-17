package com.etop.controller;

import com.etop.pojo.Permission;
import com.etop.pojo.Role;
import com.etop.pojo.User;
import com.etop.service.IPermissionService;
import com.etop.service.IRoleService;
import com.etop.service.IUserService;
import com.etop.service.Impl.LoginServiceImpl;
import com.etop.util.RequiredPermission;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;
import java.util.List;

/**
 * Created by 63574 on 2017/7/14.
 */
//查询权限

@Controller
@RequestMapping("/homePage")
public class HomePageController{

    @Autowired
    IUserService userService;

    @Autowired
    IPermissionService permissionService;

    @Autowired
    IRoleService roleService;

    @RequiredPermission("用户查询")
    @RequestMapping("/userManagement")
    public ModelAndView userManagement(@RequestParam(value = "pn",defaultValue ="1")Integer pn, Model model){
        PageHelper.startPage(pn, 10);
        ModelAndView mav = new ModelAndView("userManagement");

        List<User> users = userService.getUsers();
        PageInfo pageInfo=new PageInfo(users);
        model.addAttribute("pageInfo",pageInfo);
        return mav;
    }

    @RequestMapping("/permissionManagement")
    @RequiredPermission("权限查询")
    public ModelAndView permissionManagement(@RequestParam(value = "pn",defaultValue ="1")Integer pn, Model model){

        ModelAndView mav = new ModelAndView("permissionManagement");
        PageHelper.startPage(pn, 10);
        List<Permission> list = permissionService.list();
        PageInfo pageInfo=new PageInfo(list);
        model.addAttribute("pageInfo",pageInfo);
        return mav;
    }

    @RequiredPermission("角色查询")
    @RequestMapping("/roleManagement")
    public ModelAndView roleManagement(@RequestParam(value = "pn",defaultValue ="1")Integer pn, Model model){
        ModelAndView mav = new ModelAndView("roleManagement");
        PageHelper.startPage(pn, 10);
        List<Role> roles = roleService.getRoles();
        PageInfo pageInfo=new PageInfo(roles);
        model.addAttribute("pageInfo",pageInfo);
        return mav;
    }



    @RequestMapping("/exit")
    public ModelAndView roleManagement(HttpServletRequest request){
        ModelAndView mav = new ModelAndView("index");
        Enumeration em = request.getSession().getAttributeNames();
        while(em.hasMoreElements()){
            request.getSession().removeAttribute(em.nextElement().toString());
        }
        return mav;
    }

}
