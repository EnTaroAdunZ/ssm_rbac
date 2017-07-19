package com.etop.dao;

import com.etop.pojo.Permission;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PermissionMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Permission record);

    Permission selectByPrimaryKey(Long id);
    Permission selectByName(String name);
    Permission selectByExpression(String expression);
    List<Permission> selectAll();
    int updateByPrimaryKey(Permission record);

}