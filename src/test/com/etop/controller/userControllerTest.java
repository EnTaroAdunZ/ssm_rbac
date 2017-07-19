package com.etop.controller;

import com.etop.pojo.User;
import com.etop.service.IUserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import java.util.List;

/**
 * Created by 63574 on 2017/7/18.
 */

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:spring-web.xml"})
public class userControllerTest {
    @Autowired
    IUserService iUserService;

    @Test
    public void  testUserKeyWord(){

        List<User> users = iUserService.selectByKeyWord("root");
        for(User user:users){
            System.out.println(user);
        }
    }

}
