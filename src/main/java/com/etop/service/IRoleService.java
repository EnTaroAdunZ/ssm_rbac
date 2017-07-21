package com.etop.service;

import com.etop.pojo.Role;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * Created by 63574 on 2017/7/14.
 */


public interface IRoleService {
    List<Role> getRoles();
    int deleteByPrimaryKey(Long id);
    List<Role> selectByKeyWord(String keyWord);
    int insert(Role record);
    Role selectByPrimaryKey(Long id);
    int updateByPrimaryKey(Role record);
    List<Role> listPermission(Long wid);
}
