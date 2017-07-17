package com.etop.service.Impl;

import com.etop.dao.UserToRoleMapper;
import com.etop.pojo.UserToRole;
import com.etop.service.IUserToRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by 63574 on 2017/7/14.
 */

@Service
public class UserToRoleServiceImpl implements IUserToRoleService {

    @Autowired
    UserToRoleMapper userToRoleMapper;


    @Override
    public int addItem(UserToRole userToRole) {
        return  userToRoleMapper.addItem(userToRole);
    }

    @Override
    public int deleteItem(UserToRole userToRole) {
        return
        userToRoleMapper.deleteItem(userToRole);
    }

    @Override
    public int deleteById(Long id) {
        return userToRoleMapper.deleteById(id);
    }

}
