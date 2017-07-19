package com.etop.controller;

import com.etop.pojo.Msg;
import com.etop.pojo.Role;
import com.etop.pojo.User;
import com.etop.service.IPermissionService;
import com.etop.service.IRoleService;
import com.etop.service.IUserService;
import com.etop.service.IloginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashSet;
import java.util.List;


/**
 * Created by 63574 on 2017/7/13.
 */
@Controller
public class LoginController{

    @Autowired
    IPermissionService permissionService;


       @Autowired
        IloginService loginServiceImpl;

        @Autowired
        IUserService userService;

        @Autowired
        IRoleService roleService;

        @Autowired
        PermissionController permissionController;

        @ResponseBody
        @RequestMapping("/checkUser")
        public Msg checkUser(@RequestParam(value = "username")String username,
                               @RequestParam(value = "password")String password ){
            User user = new User();
            user.setAccount(username);
            user.setPassword(password);
            User temp=loginServiceImpl.login(user);
            if(temp==null){
                return Msg.fail();
            }
            else{
                return Msg.success();
            }
        }

        @RequestMapping("/login")
        public ModelAndView handleEnter(){
            ModelAndView mav = new ModelAndView("index");
            return mav;
        }

        @RequestMapping("/notpermission")
        public ModelAndView handleNotpermission(){
            ModelAndView mav = new ModelAndView("notpermission");
            return mav;
        }





        @RequestMapping("/user/index")
        public ModelAndView handleLogin(User user, HttpServletRequest httpServletRequest){

        HttpSession session =
                    httpServletRequest.getSession();
            Long id = (Long) session.getAttribute("id");
            User temp=loginServiceImpl.login(user);
            if(user.getAccount()==null||user.getPassword()==null){
                //从别的界面来
                if(id==null){
                    //没有登陆过
                    ModelAndView mav = new ModelAndView("index");
                    return  mav;
                }
                else {
                    //登录过加载原来的数据
                    ModelAndView mav = new ModelAndView("personalHomepage");
                    temp=userService.selectByPrimaryKey(id);
                    mav.addObject("user",temp);

                    return  mav;
                }
            }
            else{
                //从登录界面来
                if(temp==null) {
                    //帐号不存在
                    ModelAndView mav = new ModelAndView("400");
                    return mav;
                }
                else {
                    //更新权限

                    session.removeAttribute("id");
                    session.removeAttribute("userPermission");
                    List<User> users = userService.listPermission(temp.getId());
                    HashSet<String> userPerssion=new HashSet<String>();
                    if(users!=null)
                        for(User u:users){
                            if(u!=null&&u.getRoleList()!=null){

                                List<Role> roles = roleService.listPermission(u.getRoleList().get(0).getId());
                                if(roles!=null){
                                    for(Role role:roles){
                                        if(role!=null){
                                            String expression = role.getPermissionList().get(0).getExpression();
                                            if(!userPerssion.contains(expression))
                                                userPerssion.add(expression);
                                        }
                                    }

                                }
                            }
                        }



                    session.setAttribute("id",temp.getId());
                    session.setAttribute("userPermission",userPerssion);
                    ModelAndView mav = new ModelAndView("personalHomepage");
                    mav.addObject("user",temp);
                    mav.addObject("userPermission",userPerssion);
                    return mav;
                }
            }


                }




}
