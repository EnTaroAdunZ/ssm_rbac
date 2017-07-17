package com.etop.service;

import com.etop.pojo.User;

import java.util.List;

/**
 * Created by 63574 on 2017/7/14.
 */
public interface IUserService{
    List<User> getUsers();
    List<User> listPermission(Long id);
    User selectByPrimaryKey(Long id);

    int deleteByPrimaryKey(Long id);

    int insert(User record);
    int updateByPrimaryKey(User record);
}
