package com.etop.service;

import com.etop.pojo.Permission;
import com.etop.pojo.Role;
import com.etop.pojo.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

/**
 * Created by 63574 on 2017/7/15.
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:spring-web.xml"})
public class roleServiceTest {

    @Autowired
    IRoleService roleService;

    @Test
    public void testListP(){

        List<Role> roles = roleService.listPermission(1L);
        System.out.println(roles.size());
        for(Role user:roles){
            List<Permission> roleList = user.getPermissionList();
            System.out.println(roleList.get(0));
        }


    }
}
