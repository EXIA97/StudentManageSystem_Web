package com.scau.service;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.scau.dao.ClassMapper;
import com.scau.model.Class;
import com.scau.model.ClassExample;

@Service("classService")
public class ClassService {

	@Autowired
	private ClassMapper classMapper;
	
	public void Add(int cid,String name,String note){
		Class newClass = new Class();
		newClass.setCid(cid);
		newClass.setName(name);
		newClass.setNote(note);
		classMapper.insert(newClass);
	}
	

	public List<Class> listAll(){
		ClassExample example = new ClassExample();
		List<Class> cidlist = classMapper.selectByExample(example);
		List<Class> classes = new ArrayList<Class>();
		for (Class class1 : cidlist) {
			classes.add(classMapper.selectByPrimaryKey(class1.getCid()));
		}
		return classes;
	}
	
	public void Delete(int cid){
		classMapper.deleteByPrimaryKey(cid);
	}
	
	public void Update(int cid,String name,String note){
		Class newClass = new Class();
		newClass.setCid(cid);
		newClass.setName(name);
		newClass.setNote(note);
		classMapper.updateByPrimaryKey(newClass);
	}

}
