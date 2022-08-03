package com.controller.comm;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class CommExceptionAdvice {
	
	@ExceptionHandler(Exception.class)
	public String exceptionAll(Exception ex, Model model) {
		System.out.println("Exceoption page hello~");
		ex.printStackTrace();
		
		model.addAttribute("msg", ex);
		return "error";
	}
}
