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
//�ϴ� resource�� �־�� �̰� src �� �Űܾ��� controller �� ã�Ƽ� �ڲ� 404 �� �ϴ£O�� 


@Controller
public class Main{

	
	@RequestMapping(value = "/main", method = RequestMethod.POST) 
	public String mapPage() {
		return "main"; //tiles.xml�� ����
	}


}