package com.etop.service.Impl;

import com.etop.dao.RoleMapper;
import com.etop.pojo.Permission;
import com.etop.pojo.Role;
import com.etop.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by 63574 on 2017/7/14.
 */
@Service
public class RoleServiceImpl implements IRoleService {

    @Autowired
    RoleMapper roleMapper;

    @Override
    public List<Role> getRoles() {
        return roleMapper.selectAll();
    }

    @Override
    public int deleteByPrimaryKey(Long id) {
        return roleMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(Role record) {
        return roleMapper.insert(record);
    }

    @Override
    public int updateByPrimaryKey(Role record) {
        return roleMapper.updateByPrimaryKey(record);
    }


    @Override
    public List<Role> listPermission(Long wid) {
        List<Role> roles = roleMapper.listPermission(wid);
        return roles;
    }
}
