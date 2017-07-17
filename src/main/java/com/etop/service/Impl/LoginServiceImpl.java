package com.etop.service.Impl;


import com.etop.dao.UserMapper;
import com.etop.pojo.User;
import com.etop.service.IloginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by 63574 on 2017/7/13.
 */
@Service
public class LoginServiceImpl implements IloginService {

    @Autowired
    UserMapper userMapper;

    @Override
    public User login(User user) {
        User temp = null;
        temp=userMapper.selectByAccount(user.getAccount());
        if(temp==null){
            return  temp;
        }
        else{
            return temp;
        }
    }

    @Override
    public User loginWithId(Long id) {
        User user = userMapper.selectByPrimaryKey(id);
        return user;
    }
}
