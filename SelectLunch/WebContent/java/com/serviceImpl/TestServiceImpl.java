package com.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.TestDao;
import com.model.Test;
import com.service.TestService;

@Service
public class TestServiceImpl implements TestService{
	
	@Autowired
	private TestDao testDao;
	
	@Override
	public List<Test> getProducts(){
		try {
			System.out.println("TestServiceImpl b");
			return testDao.selectList("testList");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw e;
		}
	}

}
