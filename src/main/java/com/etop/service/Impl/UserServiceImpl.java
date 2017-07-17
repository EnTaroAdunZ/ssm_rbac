package com.etop.service.Impl;

import com.etop.dao.UserMapper;
import com.etop.pojo.User;
import com.etop.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by 63574 on 2017/7/14.
 */
@Service
public class UserServiceImpl implements IUserService{

    @Autowired
    UserMapper userMapper;

    @Override
    public List<User> getUsers() {
        return userMapper.selectAll();
    }

    @Override
    public List<User> listPermission(Long id) {
        return userMapper.listPermission(id);
    }

    @Override
    public User selectByPrimaryKey(Long id) {
        return userMapper.selectByPrimaryKey(id);
    }

    @Override
    public int deleteByPrimaryKey(Long id) {
        return userMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(User record) {
        return userMapper.insert(record);
    }

    @Override
    public int updateByPrimaryKey(User record) {
        return userMapper.updateByPrimaryKey(record);
    }
}
