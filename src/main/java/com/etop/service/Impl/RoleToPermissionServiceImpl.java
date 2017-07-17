package com.etop.service.Impl;

import com.etop.dao.RoleToPermissionMapper;
import com.etop.pojo.RoleToPermission;
import com.etop.service.IRoleToPermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by 63574 on 2017/7/15.
 */
@Service
public class RoleToPermissionServiceImpl implements IRoleToPermissionService {
    @Autowired
    RoleToPermissionMapper roleToPermissionMapper;

    @Override
    public int addItem(RoleToPermission userToRole) {
        return  roleToPermissionMapper.addItem(userToRole);
    }

    @Override
    public int deleteItem(RoleToPermission userToRole) {
        return  roleToPermissionMapper.deleteItem(userToRole);
    }

    @Override
    public int deleteById(Long id) {
        return roleToPermissionMapper.deleteById(id);
    }
}
