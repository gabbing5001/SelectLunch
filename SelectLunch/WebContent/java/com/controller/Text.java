package com.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.model.Test;
import com.service.TestService;
import com.serviceImpl.TestServiceImpl;

@Controller
public class Text{	
	@Autowired
	private TestServiceImpl testService;
	
	
	@RequestMapping(value = "/text", method = RequestMethod.POST) 
	public String mapPage(Model model) {
		List<Test> test;
		try {
			System.out.println("testService b");
			test = testService.getProducts();
			System.out.println("testService 5");
			model.addAttribute("test", test);
			
			for(int i=0; i<test.size(); i++) {
				System.out.println(">>>" + test.get(i));
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw e;
		}
		
		return "text"; //tiles.xml¿¡ ¿¬°á
	}

}
