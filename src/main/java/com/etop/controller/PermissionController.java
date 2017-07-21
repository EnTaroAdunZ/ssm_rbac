package com.etop.controller;

import com.etop.pojo.*;
import com.etop.service.IPermissionService;
import com.etop.service.IRoleService;
import com.etop.service.IRoleToPermissionService;
import com.etop.service.IUserService;
import com.etop.util.RequiredPermission;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

/**
 * Created by 63574 on 2017/7/14.
 */

@Controller
@RequestMapping("/permission")
public class PermissionController{


    @Autowired
    IUserService userService;

    @Autowired
    IPermissionService permissionService;

    @Autowired
    IRoleService roleService;

    @Autowired
    IRoleToPermissionService roleToPermissionService;


    @RequestMapping("/getPermissionByEdit")
    public Msg getPermissionByEdit(@RequestParam(value = "ID")Long ID){
        Permission permission = permissionService.selectByPrimaryKey(ID);
        if(permission==null){
            Msg fail = Msg.fail();
            fail.setMsg("数据库错误，该权限不存在！");
            return fail;
        }
        else{
            return Msg.success().add("permission",permission);
        }

    }

    @RequiredPermission("权限添加")
    @RequestMapping("/permissionAdd")
    public ModelAndView roleAdd(Permission permission,@RequestParam(value = "pn",defaultValue ="1")Integer pn, Model model){
        StringBuilder sb= new StringBuilder().append("com.test.");
        sb.append(permission.getExpression());
        permission.setExpression(sb.toString());
        permissionService.insert(permission);
        return new ModelAndView("redirect:/homePage/permissionManagement");
    }
    @RequiredPermission("权限编辑")
    @RequestMapping("/permissionEdit")
    public ModelAndView roleEdit(Permission permission,@RequestParam(value = "pn",defaultValue ="1")Integer pn
            , Model model,@RequestParam(value = "keyWord",defaultValue ="") String keyWord){
        StringBuilder sb= new StringBuilder().append("com.test.");
        sb.append(permission.getExpression());
        permission.setExpression(sb.toString());
        permissionService.updateByPrimaryKey(permission);
        ModelAndView modelAndView = new ModelAndView("redirect:/homePage/permissionManagement");
        modelAndView.addObject("keyWord",keyWord);
        modelAndView.addObject("pn",pn);
        return modelAndView;
    }
    @RequiredPermission("权限删除")
    @RequestMapping("/permissionDelete")
    public ModelAndView roleDelete(@RequestParam(value = "ID",defaultValue ="0") Long ID,@RequestParam(value = "pn",defaultValue ="1")Integer pn
            , Model model,@RequestParam(value = "keyWord",defaultValue ="") String keyWord){
        permissionService.deleteByPrimaryKey(ID);

        ModelAndView modelAndView = new ModelAndView("redirect:/homePage/permissionManagement");
        modelAndView.addObject("keyWord",keyWord);
        modelAndView.addObject("pn",pn);
        return modelAndView;
    }



    @ResponseBody
    @RequestMapping("/permissionModel")
    public Msg permissionModel(@RequestParam(value = "ID",defaultValue ="0") Long ID,HttpServletRequest httpServletRequest){
        HttpSession session =
                httpServletRequest.getSession();
        Long id = (Long) session.getAttribute("id");
        List<User> users = userService.listPermission(id);
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
        Permission permission = permissionService.selectByPrimaryKey(ID);
        if(userPerssion.contains(permission.getExpression())){
            return Msg.success();
        }else{
            return Msg.fail();
        }


    }


    @ResponseBody
    @RequiredPermission("分配角色权限")
    @RequestMapping(value = "/updatePermissionJson", method = RequestMethod.GET)
    public Msg updatePermissionJson(
                                    @RequestParam(value = "permissionList")List<Long> permissionList
    ){
        Long ID=permissionList.get(0);

        roleToPermissionService.deleteById(ID);
        boolean isBegin=true;
        for(Long id:permissionList){
            if(isBegin){
                isBegin=false;
                continue;
            }
            RoleToPermission roleToPermission=new RoleToPermission();
            Role role = new Role();
            role.setId(ID);
            Permission permission=new Permission();
            permission.setId(id);
            roleToPermission.setRole(role);
            roleToPermission.setPermission(permission);
            roleToPermissionService.addItem(roleToPermission);
        }
        return Msg.success();
    }




    @RequestMapping("/permissionTest")
    public ModelAndView permissionTest(){
        ModelAndView mav = new ModelAndView("permissionTest");
        List<Permission> list = permissionService.list();
        mav.addObject("permission",list);
        return mav;
    }

    @ResponseBody
    @RequiredPermission("浏览角色所有权限")
    @RequestMapping("/getPermissionJson")
    public Msg getPermissionJson(@RequestParam(value = "ID") Long ID){
        List<PermissionJson> permissionJsonList=new ArrayList<>();
        List<Permission> list = permissionService.list();
        List<Role> roles = roleService.listPermission(ID);

        for(Permission p:list){
            PermissionJson permissionJson = new PermissionJson();
            permissionJson.setExit(false);
            permissionJson.setPermission(p);
            permissionJsonList.add(permissionJson);
        }

        for(Role role:roles){
            if(role!=null){
                List<Permission> permissionList = role.getPermissionList();
                if(permissionList!=null){
                    for(PermissionJson permissionJson:permissionJsonList){
                        String jsonName = permissionJson.getPermission().getName();
                        String permissionName = permissionList.get(0).getName();
                        if(jsonName.equals(permissionName)){

                            permissionJson.setExit(true);
                            }
                        }
                    }
                }
            }
        return Msg.success().add("permissionJsonList",permissionJsonList);
        }
    }




