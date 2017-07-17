package com.etop.service;

import com.etop.pojo.RoleToPermission;

/**
 * Created by 63574 on 2017/7/15.
 */
public interface IRoleToPermissionService {
    int addItem(RoleToPermission userToRole);
    int deleteItem(RoleToPermission userToRole);
    int deleteById(Long id);
}
