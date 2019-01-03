package com.scau.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.scau.model.Student;
import com.scau.service.StudentService;
import com.scau.util.Page;

@Controller
public class StudentController {

	@Resource
	private StudentService studentService;

	@RequestMapping(value = "/addStudent", method = RequestMethod.POST)
	public String AddStudent(HttpServletRequest request, HttpServletResponse response) {
		try {
			String sid = request.getParameter("sid");
			String name = request.getParameter("name");
			String sex = request.getParameter("sex");
			String age = request.getParameter("age");
			String address = request.getParameter("address");
			String cidString = request.getParameter("cid");
			
			System.out.println(sex);
			
			if (!(sex.equals("男")||sex.equals("女"))){
				System.out.println("sex is not valid");
				return "addStudent";
			}
			
			Integer.parseInt(age);
			
			int cid = Integer.parseInt(cidString);
			studentService.Add(sid, name, sex, age, address, cid);
			return "redirect:/showAllStudent";
		} catch (Exception e) {
			e.printStackTrace();
			return "addStudent";
		}
	}

	@RequestMapping(value = "/showAllStudent")
	public String ListStudent(HttpServletRequest request, HttpServletResponse response) {
		// 获取分页参数
		int start = 0;
		int count = 10;

		try {
			start = Integer.parseInt(request.getParameter("page.start"));
			count = Integer.parseInt(request.getParameter("page.count"));
		} catch (Exception e) {
		}

		Page page = new Page(start, count);
		List<Student> students = studentService.list(page.getStart(), page.getCount());

		List<Integer> cidlist = studentService.findAllCid();

		int total = studentService.getTotal();
		page.setTotal(total);

		request.getSession().setAttribute("students", students);
		request.getSession().setAttribute("page", page);
		request.getSession().setAttribute("cidlist", cidlist);
		
		return "listStudent";
	}
	
	@RequestMapping(value = "/searchStudent")
	public String searchStudent(HttpServletRequest request, HttpServletResponse response) {
		// 获取分页参数
		int start = 0;
		int count = 10;
		int cid = 0;
		try {
			start = Integer.parseInt(request.getParameter("page.start"));
			count = Integer.parseInt(request.getParameter("page.count"));
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (request.getParameter("cid")!=null){
			cid = Integer.parseInt(request.getParameter("cid"));
			request.getSession().setAttribute("cid", cid);
		}
		else {
			cid = Integer.parseInt(request.getSession().getAttribute("cid").toString());
		}

		
		Page page = new Page(start, count);
		List<Student> students = studentService.listByCid(cid, page.getStart(), page.getCount());

		List<Integer> cidlist = studentService.findAllCid();
		int total = studentService.getTotalByCid(cid);
		page.setTotal(total);

		request.getSession().setAttribute("students", students);
		request.getSession().setAttribute("page", page);
		request.getSession().setAttribute("cidlist", cidlist);
				
		return "listStudent";
	}

	@RequestMapping(value = "/updateStudent")
	public String update(HttpServletRequest request, HttpServletResponse response) {
		try {
			String tds = request.getParameter("tds");
			String[] stu_arr = tds.split("end");
			for (int i = 0; i < stu_arr.length; i++) {
				String[] valueStrings = stu_arr[i].split("_");
				String sid = valueStrings[0];
				String name = valueStrings[1];
				String age = valueStrings[2];
				String sex = valueStrings[3];
				String address = valueStrings[4];
				int cid = Integer.parseInt(valueStrings[5]);
				List<Integer> cidlist = studentService.findAllCid();
				//检查年龄
				try {
					Integer.parseInt(age);
				}
				catch (Exception e) {
					continue;
				}
				//检查输入的cid是否合法
				if (!cidlist.contains(cid)){
					System.out.println("cid is not valid");
					continue;
				}
				//检查输入的性别是否合法
				else if (!(sex.equals("男")||sex.equals("女"))){
					System.out.println("sex is not valid");
					continue;
				}
				else {
					studentService.Update(sid, name, sex, age, address, cid);
				}		
				}
			return "redirect:/showAllStudent";
		}
		catch (Exception e) {
			return "redirect:/showAllStudent";
		}

	}

	@RequestMapping(value = "/deleteStudent")
	public String delete(HttpServletRequest request, HttpServletResponse response) {
		String ids = request.getParameter("ids");
		if (ids == null) {
			return "没有选择任何学生";
		}
		String[] id_arr = ids.split("_");
		for (int i = 0; i < id_arr.length; i++) {
			String sid = id_arr[i];
			studentService.Delete(sid);
		}
		return "listStudent";
	}

}
