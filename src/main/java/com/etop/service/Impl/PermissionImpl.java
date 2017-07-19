package com.etop.service.Impl;
import com.etop.dao.PermissionMapper;
import com.etop.dao.RoleMapper;
import com.etop.dao.RoleToPermissionMapper;
import com.etop.dao.UserMapper;
import com.etop.pojo.Permission;
import com.etop.pojo.Role;
import com.etop.pojo.RoleToPermission;
import com.etop.pojo.UserToRole;
import com.etop.service.IPermissionService;
import com.etop.util.PermissionUtil;
import com.etop.util.RequiredPermission;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

import java.lang.reflect.Method;
import java.util.List;
import java.util.Map;


@Service
public class PermissionImpl implements IPermissionService,ApplicationContextAware{

    @Autowired
    private ApplicationContext ctx;

    @Autowired
    private PermissionMapper permissionMapper;

    @Autowired
    private RoleToPermissionMapper roleToPermissionMapper;

    @Autowired
    private RoleMapper roleMapper;

    @Override
    public List<Permission> list() {
        return permissionMapper.selectAll();
    }

    @Override
    public void reload() {

        List<Permission> permissions = permissionMapper.selectAll();
        Map<String, Object> beansWithAnnotation = ctx.getBeansWithAnnotation(Controller.class);
        for(Map.Entry<String,Object> entry:beansWithAnnotation.entrySet()){
            Class<?> aClass = entry.getValue().getClass();
            Method[] declaredMethods = aClass.getDeclaredMethods();
            for(Method m:declaredMethods){
                if(m.isAnnotationPresent(RequiredPermission.class)){
                    Permission permission = PermissionUtil.methodToPermission(m);
                    if(!permissions.contains(permission)){
                        this.save(permission);
                    }
                }
            }
        }
        //给超级管理员更新权限


    }

    @Override
    public void save(Permission permission) {

         permissionMapper.insert(permission);
        permission.setId(permission.getId());
        Role role = roleMapper.selectByPrimaryKey(1L);
        RoleToPermission rtp=new RoleToPermission();
        rtp.setRole(role);
        rtp.setPermission(permission);
        roleToPermissionMapper.addItem(rtp);
    }

    @Override
    public int insert(Permission record) throws RuntimeException{
        Permission permission = permissionMapper.selectByExpression(record.getExpression());
        if(permission!=null){
            throw new RuntimeException("权限表达式已存在！请重新输入！");
        }
        Permission permission1 = permissionMapper.selectByName(record.getName());
        if (permission != null) {
            throw new RuntimeException("权限名已经存在！请重新输入！");
        }
        return   permissionMapper.insert(record);
    }

    @Override
    public int deleteByPrimaryKey(Long id) {
        return permissionMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKey(Permission record) {
        return permissionMapper.updateByPrimaryKey(record);
    }

    @Override
    public Permission selectByPrimaryKey(Long id) {
        return permissionMapper.selectByPrimaryKey(id);
    }

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.ctx=applicationContext;

        this.reload();
    }



}
