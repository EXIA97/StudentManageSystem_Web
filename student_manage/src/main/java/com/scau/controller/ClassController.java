package com.scau.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.lang.ProcessBuilder.Redirect;
import java.util.List;

import com.scau.model.Class;
import com.scau.service.ClassService;

@Controller
public class ClassController {
	
	@Resource
	private ClassService classService;
	
	@RequestMapping (value="/addClass",method=RequestMethod.POST)
	public String AddClass(HttpServletRequest request,HttpServletResponse response,Model model){
		
		try {
			int cid = Integer.parseInt(request.getParameter("cid").trim());
			String name = request.getParameter("name");
			String note = request.getParameter("note");
			if (name==null||note==null){
				return "addClass";
			}
			else {
				classService.Add(cid, name, note);
				return "redirect:/showAllClass";
			}
		}
		catch (NumberFormatException e) {
			return "addClass";
		}	
	}
	
	@RequestMapping(value="/showAllClass")
	public String ListClass(HttpServletRequest request, HttpServletResponse response,Model model){
			List<Class> classes = classService.listAll();
			request.getSession().setAttribute("classes", classes);
			return "listClass";
	}
	
	@RequestMapping(value="/deleteClass")
	   public String delete(HttpServletRequest request, HttpServletResponse response) {
        String ids = request.getParameter("ids");
        if (ids == null) {
            return "没有选择任何班级";
        }
        String[] id_arr = ids.split("_");
        for (int i = 0 ; i< id_arr.length;i++){
        	int cid = Integer.parseInt(id_arr[i]);
            classService.Delete(cid);
        }
        return "listClass";
    }
	
	@RequestMapping(value="/updateClass")
	public String update(HttpServletRequest request,HttpServletResponse response){
		String tds = request.getParameter("tds");
		String[] class_arr = tds.split("end");
		for (int i = 0; i < class_arr.length ; i++){
			String[] valueStrings = class_arr[i].split("_");
			int cid  = Integer.parseInt(valueStrings[0]);
			String name = valueStrings[1];
			String note = valueStrings[2];
			classService.Update(cid, name, note);
		}
		return "listClass";
	}

}
