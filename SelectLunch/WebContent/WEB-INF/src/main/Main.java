package main;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



public class Main extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException
			{
				String map = null;
				PrintWriter out = res.getWriter();
				map = req.getParameter("test");
				System.out.println("¿À´Ï???");
				try {
					req.setAttribute("map", map);
					
					String url = "/jsp/map/map.jsp";
					
					RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
					rd.include(req, res);
					out.flush();
				}catch(Exception e) {
					e.printStackTrace();
					return;
				}
				
			}

}
