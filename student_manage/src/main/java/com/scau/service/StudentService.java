package com.scau.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.scau.dao.ClassMapper;
import com.scau.dao.StudentMapper;
import com.scau.model.Class;
import com.scau.model.ClassExample;
import com.scau.model.Student;
import com.scau.model.StudentExample;

@Service
public class StudentService {
	
	@Autowired
	private StudentMapper studentMapper;
	
	@Autowired
	private ClassMapper classMapper;
	
	public void Add(String sid,String name,String sex,String age,String address,int cid){
		try {
			Student student = new Student();
			student.setSid(sid);
			student.setName(name);
			student.setSex(sex);
			student.setAge(age);
			student.setAddress(address);
			student.setCid(cid);
			student.setValid(true);
			studentMapper.insert(student);
		}
		catch (NumberFormatException e) {
			e.printStackTrace();
		}
	}
	
	 	public List<Student> list(int start, int count) {
		  	return studentMapper.list(start, count);
	    }
	  
	    public int getTotal() {
	    	StudentExample example = new StudentExample();
			List<Student> sidlist = studentMapper.selectByExample(example);
	        return sidlist.size();
	    }
	    
		public void Update(String sid,String name,String sex,String age,String address,int cid){
			try {
				Student student = new Student();
				student.setSid(sid);
				student.setName(name);
				student.setSex(sex);
				student.setAge(age);
				student.setAddress(address);
				student.setCid(cid);
				student.setValid(true);
				studentMapper.updateByPrimaryKey(student);
			}
			catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		
		public void Delete(String sid){
			studentMapper.logicDelete(sid);
		}
		
		public List<Integer> findAllCid(){
			List<Integer> cidlist = new ArrayList<Integer>();
			List<Class> classList = classMapper.selectByExample(new ClassExample());
			for (Class class1:classList) {
				if (!cidlist.contains(class1.getName())){
					cidlist.add(class1.getCid());
				}
			}
			return cidlist;
			
		}
		
		public List<Student> listByCid(int cid,int start, int count) {
		  	return studentMapper.listByCid(cid, start, count);
	    }
		
		public int getTotalByCid(int cid){
			return studentMapper.listByCidAll(cid).size();
		}
		
}
