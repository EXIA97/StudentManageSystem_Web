package com.scau.controller;

import com.scau.model.Admin;
import com.scau.service.AdminService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.Date;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
public class AdminController {

    @Resource
    private AdminService adminService;

    @RequestMapping(value="/login",method=RequestMethod.POST)
	public String login(HttpServletRequest request, HttpServletResponse response) {
		String aid = request.getParameter("aid");
		String passwd = request.getParameter("passwd");
		if (aid == null || passwd == null) {
			return "login";
		} else {
			Admin admin = adminService.get(aid);
			if (admin!=null && passwd.equals(admin.getPasswd())) {
				//  记录当前登录时间并更新
				Date date = new Date();
				admin.setAid(aid);
				admin.setPasswd(passwd);
				admin.setLastlogin(date);
				adminService.Update(admin);
				
				//	保存当前的登陆状态
				request.getSession().setAttribute("adminID", admin.getAid());
				request.getSession().setAttribute("lastLogin", admin.getLastlogin());
				return "menu";
			} else {
				return "login";
			}
		}
	}
    
    @RequestMapping(value="/logout",method=RequestMethod.POST)
    public String logout(HttpServletRequest request, HttpServletResponse response){
    	request.getSession().setAttribute("adminID", null);
		request.getSession().setAttribute("lastLogin", null);
		return "login";
    }
}
