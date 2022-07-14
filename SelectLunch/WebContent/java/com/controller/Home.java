package com.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
//일단 resource에 넣어둠 이거 src 로 옮겨야함 controller 못 찾아서 자꾸 404 남 하는즁임 
//디비연결도 해보기 model 만들자 
//tocken 생성해서 git에 올리기 

@Controller
@RequestMapping(value = "/") 
public class Home{

	public String homePage() {
		return "redirect:/SelectLunch"; //rootcontext 따로 안잡고 이런식으로 처리
	}


}
