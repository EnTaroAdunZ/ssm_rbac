package com.etop.controller;

import com.etop.pojo.Msg;
import com.etop.pojo.User;
import com.etop.service.IUserService;
import com.etop.util.RequiredPermission;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.aspectj.lang.annotation.RequiredTypes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by 63574 on 2017/7/14.
 */

@Controller
@RequestMapping("/user")
public class UserController{

    @Autowired
    IUserService userService;

    @ResponseBody
    @RequestMapping("/checkUserExit")
    public Msg getPermissionJson(@RequestParam(value = "userName")String userName){
        boolean b = userService.checkUserExit(userName);
        if(b){
            return Msg.success();
        }
        else{
            return Msg.fail();
        }
    }

    @ResponseBody
    @RequestMapping("/getUserByKeyWord")
    public Msg getUserByKeyWord(@RequestParam(value = "KeyWord")String KeyWord,
                                @RequestParam(value = "pn",defaultValue ="1")Integer pn
                               ){
        PageHelper.startPage(pn, 10);
        List<User> users = userService.selectByKeyWord(KeyWord);
        PageInfo pageInfo=new PageInfo(users);
        return Msg.success().add("pageInfo",pageInfo);
    }

    @ResponseBody
    @RequiredPermission("用户编辑_回显")
    @RequestMapping("/getUserById")
    public Msg getUserById(@RequestParam(value = "ID")Long ID){
        User user = userService.selectByPrimaryKey(ID);
        return Msg.success().add("user",user);
    }

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
