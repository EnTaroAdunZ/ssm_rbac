package com.etop.controller;

import com.etop.util.RequiredPermission;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * Created by 63574 on 2017/7/16.
 */
@Controller
@RequestMapping("/simulationController")
public class simulationController {

    @RequiredPermission("播放音乐")
    @RequestMapping("/playMusic")
    public ModelAndView permissionBrowse(){
     return new ModelAndView("notpermission") ;
    }
}


