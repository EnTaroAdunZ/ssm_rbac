package com.etop.service;

import com.etop.pojo.Permission;

import java.nio.channels.Pipe;
import java.util.List;

/**
 * Created by 63574 on 2017/7/14.
 */
public interface IPermissionService {
    List<Permission> list();
    void reload();
    void save(Permission permission);
    int insert(Permission record);
    int deleteByPrimaryKey(Long id);
    int updateByPrimaryKey(Permission record);
}
