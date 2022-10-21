package com.controller.comm;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

//이 어노테이션이 익셉션 잡아줌
@ControllerAdvice
public class CommExceptionAdvice { //controller 에서 exception 던지면 여기로 옴 
	
	//디테일 하게 변경해야 함 지금 최상위 익센션으로 설정 잡아서 모든 익셉션 발생시 여기로 옴
	@ExceptionHandler(Exception.class) 
	public String exceptionAll(Exception ex, Model model) {
		System.out.println("Exceoption page hello~");
		ex.printStackTrace();
		
		//메세지 전체 담으면 안됨 세분화 한 뒤 나눠야 함 
		model.addAttribute("msg", ex);
		//에러 페이지로 이동
		return "error";
	}
}
