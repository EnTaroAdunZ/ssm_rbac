package com.etop.service;

import com.etop.pojo.Role;
import com.etop.pojo.User;
import com.etop.pojo.UserToRole;

import java.util.List;

/**
 * Created by 63574 on 2017/7/14.
 */
public interface IUserToRoleService {
    int addItem(UserToRole userToRole);
    int deleteItem(UserToRole userToRole);
    int deleteById(Long id);
}
