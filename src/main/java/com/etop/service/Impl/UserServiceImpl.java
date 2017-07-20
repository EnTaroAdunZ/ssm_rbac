package com.etop.service.Impl;

import com.etop.dao.UserMapper;
import com.etop.pojo.User;
import com.etop.service.IUserService;
import com.etop.util.PasswordUtil;
import org.omg.SendingContext.RunTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
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
    public List<User> selectByKeyWord(String keyWord) {
        return userMapper.selectByKeyWord(keyWord);
    }

    @Override
    public int deleteByPrimaryKey(Long id) {
        return userMapper.deleteByPrimaryKey(id);
    }

    @Override
    public boolean checkUserExit(String username) {
        User user = userMapper.selectByAccount(username);
        if(user!=null){
            return false;
        }
        return true;
    }

    @Override
    public int insert(User record) throws RuntimeException{
        User user = userMapper.selectByAccount(record.getAccount());
        if(user!=null){
            throw new RuntimeException("帐号已经存在！请换一个帐号!");
        }
        User user1 = userMapper.selectByName(record.getName());
        if(user1!=null){
            throw new RuntimeException("昵称已经存在！请换一个昵称!");
        }

        //开始加密过程
        String generate = PasswordUtil.generate(record.getPassword());
        record.setPassword(generate);
        return userMapper.insert(record);
    }

    @Override
    public int updateByPrimaryKey(User record) {
        return userMapper.updateByPrimaryKey(record);
    }
}
