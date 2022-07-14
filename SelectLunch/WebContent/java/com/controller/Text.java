package com.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class Text{
	
	@RequestMapping(value = "/text", method = RequestMethod.POST) 
	public String mapPage() {
		return "text"; //tiles.xml¿¡ ¿¬°á
	}

}
