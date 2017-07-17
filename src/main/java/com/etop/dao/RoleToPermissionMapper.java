package com.etop.dao;

import com.etop.pojo.RoleToPermission;
import com.etop.pojo.UserToRole;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RoleToPermissionMapper {
    int addItem(RoleToPermission userToRole);
    int deleteItem(RoleToPermission userToRole);
    int deleteById(Long id);
}