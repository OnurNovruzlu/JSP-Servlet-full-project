package com.mycompany.supermarketweb;

import config.Context;
import dao.inter.UserDaoInter;
import entity.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    private UserDaoInter udao = Context.instanceUserDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            User u = udao.findByUsernameAndPassword(username, password);
            if (u == null) {
                throw new IllegalArgumentException("Email or password is incorrect!!");
            }
            request.getSession().setAttribute("loggedInUser", u);
            response.sendRedirect("products");
        } catch (Exception ex) {
            response.sendRedirect("error?msg=" + ex.getMessage());
        }
    }
}
