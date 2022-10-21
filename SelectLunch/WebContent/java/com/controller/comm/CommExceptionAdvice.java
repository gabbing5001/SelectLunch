package com.controller.comm;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

//�� ������̼��� �ͼ��� �����
@ControllerAdvice
public class CommExceptionAdvice { //controller ���� exception ������ ����� �� 
	
	//������ �ϰ� �����ؾ� �� ���� �ֻ��� �ͼ������� ���� ��Ƽ� ��� �ͼ��� �߻��� ����� ��
	@ExceptionHandler(Exception.class) 
	public String exceptionAll(Exception ex, Model model) {
		System.out.println("Exceoption page hello~");
		ex.printStackTrace();
		
		//�޼��� ��ü ������ �ȵ� ����ȭ �� �� ������ �� 
		model.addAttribute("msg", ex);
		//���� �������� �̵�
		return "error";
	}
}
