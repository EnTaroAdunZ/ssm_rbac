package com.etop.controller;

import com.etop.pojo.*;
import com.etop.service.IRoleService;
import com.etop.service.IUserService;
import com.etop.service.IUserToRoleService;
import com.etop.util.RequiredPermission;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by 63574 on 2017/7/14.
 */

@Controller
@RequestMapping("/role")
public class RoleController {

    @Autowired
    IRoleService roleService;

    @Autowired
    IUserService userService;

    @Autowired
    IUserToRoleService userToRoleService;

    @RequiredPermission("权限浏览")
    @RequestMapping("/permissionBrowse")
    public ModelAndView permissionBrowse(@RequestParam(value = "pn",defaultValue ="1")Integer pn,
                                         @RequestParam(value = "wid",defaultValue ="0")Long wid,
                                         Model model){
        ModelAndView mav = new ModelAndView("permissionBrowse");
        PageHelper.startPage(pn, 10);
        List<Role> roles = roleService.listPermission(wid);
        PageInfo pageInfo=new PageInfo(roles);
        model.addAttribute("pageInfo",pageInfo);
        return mav;
    }


    @ResponseBody
    @RequestMapping("/getRoleById")
    public Msg getRoleById(@RequestParam(value = "ID")Long ID){
        Role role = roleService.selectByPrimaryKey(ID);
        if(role!=null){
            return Msg.success().add("role",role);
        }
        else{
            Msg fail = Msg.fail();
            fail.setMsg("数据库错误，该角色不存在！");
            return fail;
        }
    }


    @RequiredPermission("角色添加")
    @RequestMapping("/roleAdd")
    public ModelAndView roleAdd(Role role){
        roleService.insert(role);
        return new ModelAndView("redirect:/homePage/roleManagement");
    }

    @RequiredPermission("角色编辑")
    @RequestMapping("/roleEdit")
    public ModelAndView roleEdit(Role role,
            @RequestParam(value = "pn",defaultValue ="1")Integer pn,
                                 @RequestParam(value = "wid",defaultValue ="0")Long wid,
                                 Model model,@RequestParam(value = "keyWord",defaultValue ="")String keyWord){
        roleService.updateByPrimaryKey(role);
        ModelAndView modelAndView = new ModelAndView("redirect:/homePage/roleManagement");
        modelAndView.addObject("keyWord",keyWord);
        modelAndView.addObject("pn",pn);
        return modelAndView;

    }
    @RequiredPermission("角色删除")
    @RequestMapping("/roleDelete")
    public ModelAndView roleDelete(@RequestParam(value = "ID",defaultValue ="0") Long ID, @RequestParam(value = "pn",defaultValue ="1")Integer pn,
                                   @RequestParam(value = "wid",defaultValue ="0")Long wid,
                                   Model model,@RequestParam(value = "keyWord",defaultValue ="")String keyWord){
        roleService.deleteByPrimaryKey(ID);
        ModelAndView modelAndView = new ModelAndView("redirect:/homePage/roleManagement");
        modelAndView.addObject("keyWord",keyWord);
        modelAndView.addObject("pn",pn);
        return modelAndView;
    }

    @RequiredPermission("权限分配")
    @RequestMapping("/roleHandlePermission")
    public ModelAndView roleHandlePermission(){

        return new ModelAndView("redirect:/homePage/roleManagement");
    }

    @ResponseBody
    @RequiredPermission("分配用户角色")
    @RequestMapping(value = "/updateRoleJson", method = RequestMethod.GET)
    public Msg updateRoleJson(
            @RequestParam(value = "roleList")List<Long> roleList
    ){
        Long ID=roleList.get(0);

        userToRoleService.deleteById(ID);
        boolean isBegin=true;
        for(Long id:roleList){
            if(isBegin){
                isBegin=false;
                continue;
            }
            UserToRole userToRole = new UserToRole();
            Role role = new Role();
            role.setId(id);
            User user=new User();
            user.setId(ID);
            userToRole.setRole(role);
            userToRole.setUser(user);
            userToRoleService.addItem(userToRole);
        }
        return Msg.success();
    }

    @ResponseBody
    @RequiredPermission("浏览用户所有角色")
    @RequestMapping("/getRoleJson")
    public Msg getRoleJson(@RequestParam(value = "ID") Long ID){
        List<RoleJson> roleJsons=new ArrayList<>();
        List<Role> list = roleService.getRoles();
        List<User> users = userService.listPermission(ID);
        for(Role r:list){
            RoleJson roleJson = new RoleJson();
            roleJson.setExit(false);
            roleJson.setRole(r);
            roleJsons.add(roleJson);
        }

        for(User user:users){
            if(user!=null){
                List<Role> roles = user.getRoleList();
                if(roles!=null){
                    for(RoleJson roleJson:roleJsons){
                        String jsonName = roleJson.getRole().getName();
                        String permissionName = roles.get(0).getName();
                        if(jsonName.equals(permissionName)){

                            roleJson.setExit(true);
                        }

                    }
                }
            }
        }
        return Msg.success().add("roleJsons",roleJsons);
    }

}
