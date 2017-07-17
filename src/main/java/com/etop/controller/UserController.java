package com.etop.controller;

import com.etop.pojo.User;
import com.etop.service.IUserService;
import com.etop.util.RequiredPermission;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * Created by 63574 on 2017/7/14.
 */

@Controller
@RequestMapping("/user")
public class UserController{

    @Autowired
    IUserService userService;


    @RequiredPermission("角色浏览")
    @RequestMapping("/roleBrowse")
    public ModelAndView browse(@RequestParam(value = "pn",defaultValue ="1")Integer pn,
                               @RequestParam(value = "wid",defaultValue ="0")Long wid,
                               Model model){
        ModelAndView mav = new ModelAndView("roleBrowse");
        PageHelper.startPage(pn, 10);

        List<User> users = userService.listPermission(wid);
        PageInfo pageInfo=new PageInfo(users);
        model.addAttribute("pageInfo",pageInfo);
        return mav;
    }


    @RequiredPermission("用户添加")
    @RequestMapping("/userAdd")
    public ModelAndView roleAdd(User user){
        userService.insert(user);
        return new ModelAndView("redirect:/homePage/userManagement");
    }
    @RequiredPermission("用户编辑")
    @RequestMapping("/userEdit")
    public ModelAndView roleEdit(User user){
        userService.updateByPrimaryKey(user);
        return new ModelAndView("redirect:/homePage/userManagement");
    }
    @RequiredPermission("用户删除")
    @RequestMapping("/userDelete")
    public ModelAndView roleDelete(@RequestParam(value = "ID",defaultValue ="0") Long ID){
        userService.deleteByPrimaryKey(ID);
        return new ModelAndView("redirect:/homePage/userManagement");
    }

}
