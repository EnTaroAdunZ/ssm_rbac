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
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
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
        boolean b = userService.checkUserNameExit(userName);
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
        System.out.println(users.size());
        PageInfo pageInfo=new PageInfo(users);
        System.out.println(pageInfo);
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
    @ResponseBody
    @RequestMapping("/userAdd")
    public Msg roleAdd(@Valid User user, BindingResult result){
        if (result.hasErrors()) {
            List<FieldError> fieldErrors = result.getFieldErrors();
            StringBuilder stringBuilder = new StringBuilder();
            for (FieldError fieldError1 : fieldErrors) {
                stringBuilder.append(fieldError1.getDefaultMessage()+"\n");
            }
            return Msg.reject().add("msg",stringBuilder.toString());
        }
        boolean b = userService.checkUserNameExit(user.getName());
        boolean b1 = userService.checkUserAccountExit(user.getAccount());
        HashMap<String, String> errorMap = new HashMap<>();
        if(b){
            errorMap.put("#add_name","昵称已经存在！");
        }
        if(b1){
            errorMap.put("#add_account","帐号已经存在！");
        }
        if(b||b1){
            return Msg.fail().add("errorMap",errorMap);
        }else{
            userService.insert(user);
            return Msg.success();
        }
    }

    @ResponseBody
    @RequiredPermission("用户编辑")
    @RequestMapping("/userEdit")
    public Msg roleEdit(@Valid User user, BindingResult result){
        if (result.hasErrors()) {
            List<FieldError> fieldErrors = result.getFieldErrors();
            StringBuilder stringBuilder = new StringBuilder();
            for (FieldError fieldError1 : fieldErrors) {
                stringBuilder.append(fieldError1.getDefaultMessage()+"\n");
            }
            return Msg.reject().add("msg",stringBuilder.toString());
        }

        User user1 = userService.selectByPrimaryKey(user.getId());
        boolean b = false;
        boolean b1 = false;
        if(!user.getAccount().equals(user1.getAccount())){
            b1 = userService.checkUserAccountExit(user.getAccount());
        }
        if(!user.getName().equals(user1.getName())){
            b=userService.checkUserNameExit(user.getName());
        }


        HashMap<String, String> errorMap = new HashMap<>();
        if(b){
            errorMap.put("#editName","昵称已经存在！");
        }
        if(b1){
            errorMap.put("#editAccount","帐号已经存在！");
        }
        if(b||b1){
            return Msg.fail().add("errorMap",errorMap);
        }else{
            userService.updateByPrimaryKey(user);
            return Msg.success();
        }
    }



    @RequiredPermission("用户删除")
    @RequestMapping("/userDelete")
    public ModelAndView roleDelete(@RequestParam(value = "ID",defaultValue ="0")
     Long ID,HttpServletRequest httpServletRequest){
        HttpSession session =
                httpServletRequest.getSession();
        Long id = (Long) session.getAttribute("id");
        if(id==ID){
            ModelAndView mav = new ModelAndView("400");
            mav.addObject("msg","无法删除自己！");
            return mav;
        }
        userService.deleteByPrimaryKey(ID);
        return new ModelAndView("redirect:/homePage/userManagement");
    }

}
