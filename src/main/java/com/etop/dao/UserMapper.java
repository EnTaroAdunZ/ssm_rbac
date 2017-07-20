package com.etop.dao;

import com.etop.pojo.User;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserMapper {
    int deleteByPrimaryKey(Long id);
    int insert(User record);
    int updateByPrimaryKey(User record);
    User selectByPrimaryKey(Long id);
    List<User> selectAll();
    User selectByAccount(String account);
    User selectByName(String name);
    List<User> listPermission(Long id);
    List<User> selectByKeyWord(String keyWord);
}