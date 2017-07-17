package com.etop.service;

import com.etop.pojo.Role;
import com.etop.pojo.User;
import com.etop.pojo.UserToRole;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

/**
 * Created by 63574 on 2017/7/15.
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:spring-web.xml"})
public class UserToRoleTest {

    @Autowired
    IUserToRoleService userToRoleService;

    @Test
    public void testAddItem(){
        UserToRole userToRole = new UserToRole();
        Role role = new Role();
        User user = new User();
        role.setId(1L);
        user.setId(2L);
        userToRole.setRole(role);
        userToRole.setUser(user);
        userToRoleService.addItem(userToRole);
    }

    @Test
    public void testdeleteItem(){
        UserToRole userToRole = new UserToRole();
        Role role = new Role();
        User user = new User();
        role.setId(1L);
        user.setId(2L);
        userToRole.setRole(role);
        userToRole.setUser(user);
        userToRoleService.deleteItem(userToRole);
    }

}
