package com.scau.service;

import com.scau.dao.AdminMapper;
import com.scau.model.Admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("adminService")
public class AdminService {

	@Autowired
	private AdminMapper adminMapper;

	public Admin get(String aid) {
		return adminMapper.selectByPrimaryKey(aid);
	}
	
	public void Update(Admin record){
		adminMapper.updateByPrimaryKey(record);
	}


}
