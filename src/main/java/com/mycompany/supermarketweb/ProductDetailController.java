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

/**
 *
 * @author HP
 */
@WebServlet(name = "ProdDetController", urlPatterns = {"/productdetail"})
public class ProductDetailController extends HttpServlet {

    private ProductDaoInter pdao = Context.instanceProductDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action=request.getParameter("action");
        int id = Integer.parseInt(request.getParameter("id"));
        if(action.equals("update")){
            
        
        String name = request.getParameter("name");
        int price = Integer.parseInt(request.getParameter("price"));

        Product p = pdao.getProductById(id);
        p.setProduct_name(name);
        p.setProduct_price(price);

        pdao.updateProduct(p);
        }
        else if(action.equals("delete")){
            pdao.removeProduct(id);
        }
        response.sendRedirect("products");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String strId = request.getParameter("id");
            if (strId == null || strId.trim().isEmpty()) {
                throw new IllegalArgumentException("specify id");
            } else {
                Integer id = Integer.parseInt(strId);
                Product p = pdao.getProductById(id);
                if (p == null) {
                    throw new IllegalArgumentException("There is no product with this id");
                }
                request.setAttribute("product", p);
                request.getRequestDispatcher("productdetail.jsp").forward(request, response);
            }
        } catch (Exception ex) {
            response.sendRedirect("error?msg=" + ex.getMessage());
        }

    }
}
