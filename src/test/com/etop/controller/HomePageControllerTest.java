package com.etop.controller;

import com.etop.pojo.User;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * Created by 63574 on 2017/7/14.
 */

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:spring-web.xml"})
public class HomePageControllerTest {
    MockMvc mockMvc;

    @Autowired
    WebApplicationContext context;

    @Before
    public void intitMockMvc(){
        mockMvc= MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        PageHelper.startPage(1,1000);
        MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders
                .get("/homePage/userManagement")
                .param("pn", "1"))
                .andReturn();
        MockHttpServletRequest request = mvcResult.getRequest();

        PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
        System.out.println("当前页码"+pageInfo.getPageNum());
        System.out.println("总页码"+pageInfo.getPages());
        System.out.println("总记录数"+pageInfo.getTotal());
        System.out.println("在页面需要连续显示的页码");
        int[] num=pageInfo.getNavigatepageNums();
        for(int i:num){
            System.out.println(" 页码："+i);
        }
        List<User> list = pageInfo.getList();
        for(User user:list){
            System.out.println(user);
        }
    }

}
