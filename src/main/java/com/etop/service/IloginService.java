package com.etop.service;


import com.etop.pojo.User;

/**
 * Created by 63574 on 2017/7/13.
 */
public interface IloginService {
    User login(User user);
    User loginWithId(Long id);
}
