package com.etop.dao;

import com.etop.pojo.UserToRole;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserToRoleMapper {

    int addItem(UserToRole userToRole);
    int deleteItem(UserToRole userToRole);
    int deleteById(Long id);
}