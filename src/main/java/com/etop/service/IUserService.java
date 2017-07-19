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
    List<User> selectByKeyWord(String keyWord);
    int deleteByPrimaryKey(Long id);
    boolean checkUserExit(String username);
    int insert(User record);
    int updateByPrimaryKey(User record);

}
