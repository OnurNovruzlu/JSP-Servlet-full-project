package com.mycompany.supermarketweb;

import config.Context;
import dao.inter.UserDaoInter;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LogoutController", urlPatterns = {"/logout"})
public class LogoutController extends HttpServlet {
    private UserDaoInter udao=Context.instanceUserDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("products.jsp").include(request, response);
        
        HttpSession session=request.getSession();
        session.invalidate();
        response.sendRedirect("login.jsp");
        
    }
}
