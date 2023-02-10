package com.mycompany.supermarketweb;

import config.Context;
import dao.inter.ProductDaoInter;
import entity.Product;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ProductAddController", urlPatterns = {"/add"})
public class ProductAddController extends HttpServlet {
    private ProductDaoInter pdao=Context.instanceProductDao();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
  
        Integer id=Integer.parseInt(request.getParameter("id"));
        String name=request.getParameter("name");
        Integer price=Integer.parseInt(request.getParameter("price"));
        Integer catid=Integer.parseInt(request.getParameter("catid"));  
        
        Product p=new Product();
        p.setProduct_id(id);
        p.setProduct_name(name);
        p.setProduct_price(price);
        p.setCategory_id(catid);
        
        pdao.insertProduct(p);
        response.sendRedirect("products");
       
    }
}
