package com.etop.test;

import com.etop.dao.UserMapper;
import com.etop.pojo.Role;
import com.etop.pojo.User;
import com.etop.service.IUserService;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.Random;

/**
 * Created by 63574 on 2017/7/14.
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:spring-web.xml"})
public class insertUser {
    @Autowired
    UserMapper userMapper;

    @Autowired
    SqlSession sqlSession;

    @Autowired
    IUserService userService;

    @Test
    public void testListP(){
        List<User> users = userService.listPermission(1L);
        System.out.println(users.size());
        for(User user:users){
            List<Role> roleList = user.getRoleList();
            System.out.println(roleList);
        }


    }

    @Test
    public void test(){
        UserMapper mapper = sqlSession.getMapper(UserMapper.class);
        for(int i=101;i<=1001;i++){
            User user=new User();
            user.setName(i+"号机");
            user.setAccount("ztf"+i);
            user.setPassword(i+"ztf");
            Random random=new Random();
            int i1 = random.nextInt(140);
            user.setAge(i1);
            long l = random.nextLong()%100000000+100000000;
            user.setExperience(l);
            user.setPhone("0752-"+String.valueOf(l));
            mapper.insert(user);
        }
    }

}
