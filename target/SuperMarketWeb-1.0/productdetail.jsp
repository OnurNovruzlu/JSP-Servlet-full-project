<%@page import="entity.Product"%>
<%@page import="config.Context"%>
<%@page import="dao.inter.ProductDaoInter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% 
            Product p = (Product) request.getAttribute("product");
        %> 
        <div style="width: 300px;margin: auto"><form action="productdetail" method="POST">
                <input type="hidden" name="id" value="<%= p.getProduct_id()%>"/>
                <input type="hidden" name="action" value="update"/>
                <div class="mb-3">
                    <label  class="form-label">Name:</label>
                    <input type="text" name="name" value="<%= p.getProduct_name()%>" class="form-control"/>
                </div>
                <div class="mb-3">
                    <label  class="form-label">Price:</label>
                    <input type="text" name="price" value="<%=p.getProduct_price()%>" class="form-control"/>
                </div>
                <input type="submit" name="save" value="Save" class="btn btn-primary"/>
            </form></div>
    </body>
</html>
