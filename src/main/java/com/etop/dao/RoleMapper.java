package com.etop.dao;

import com.etop.pojo.Role;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RoleMapper {
    int deleteByPrimaryKey(Long id);
    int insert(Role record);
    int updateByPrimaryKey(Role record);
    Role selectByPrimaryKey(Long id);
    List<Role> selectAll();
    Role selectBySn(String sn);
    Role selectByName(String name);
    List<Role> listPermission(Long wid);
    List<Role> selectByKeyWord(String keyWord);
}