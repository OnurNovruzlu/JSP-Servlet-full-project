<%@page import="java.util.List"%>
<%@page import="dao.inter.ProductDaoInter"%>
<%@page import="config.Context"%>
<%@page import="entity.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="assets/css/product.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <script src="assets/js/product.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Products Page</title>
    </head>
    <body>
        <% ProductDaoInter pdao = Context.instanceProductDao();

            String name = request.getParameter("name");
            String priceStr = request.getParameter("price");
            Integer price = null;
            if (priceStr != null && !priceStr.trim().isEmpty()) {
                price = Integer.parseInt(priceStr);
            }
            List<Product> list = pdao.getAllProduct(name, price);

        %> 
        <div>
            <!-- Search Form -->          
            <div style="width: 300px; float: left;">

                <form action="products" method="GET" >
                    <input type="hidden" name="id" value=""/>
                    <div class="mb-3">
                        <label  class="form-label">Name:</label>
                        <input type="text" name="name" value="" class="form-control"/>
                    </div>
                    <div class="mb-3">
                        <label  class="form-label">Price:</label>
                        <input type="text" name="price" value="" class="form-control"/>
                    </div>
                    <input type="submit" name="search" value="Search" class="btn btn-primary"/>
                </form></div>
            <div align="right">
                <a href="logout"><button type="submit" name="search" value="Search" class="btn btn-primary">Logout</button></a>
            </div>
            <!-- Add Form -->  
            <div style=" width: 300px; float: right;">
                <form action="add" method="POST" >  
                    <div class="mb-3">
                        <label  class="form-label">ID:</label>
                        <input type="text" name="id" value="" class="form-control"/>
                    </div>
                    <div class="mb-3">
                        <label  class="form-label">Name:</label>
                        <input type="text" name="name" value="" class="form-control"/>
                    </div>
                    <div class="mb-3">
                        <label  class="form-label">Price:</label>
                        <input type="text" name="price" value="" class="form-control"/>
                    </div>
                    <div class="mb-3">
                        <label  class="form-label">CatId:</label>
                        <input type="text" name="catid" value="" class="form-control"/>
                    </div>
                    <input type="submit" name="add" value="Add" class="btn btn-primary"/>
                </form></div>
        </div> 
        <div>
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">Name</th>
                        <th scope="col">Price</th>
                        <th scope="col">Category</th>
                        <th scope="col">Operation</th>
                    </tr>
                </thead>
                <tbody>
                    <%for (Product p : list) {%>
                    <tr>
                        <td><%=p.getProduct_name()%></td>
                        <td><%=p.getProduct_price()%></td>
                        <td><%=p.getCategory().getCategory_name() == null ? "" : p.getCategory().getCategory_name()%></td>
                        <td style="width: 5px;">
                            <!-- Button trigger modal -->
                            <button onclick="setIdForDelete(<%= p.getProduct_id()%>)" type="submit" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#exampleModal">
                                <input type="hidden" name="id" value="<%= p.getProduct_id()%>" />
                                <input type="hidden" name="action" value="delete" />
                                <i class="fa-sharp fa-solid fa-trash"></i>
                            </button>
                        </td>
                        <td style="width: 5px;">
                            <form action="productdetail" method="GET">
                                <input type="hidden" name="id" value="<%= p.getProduct_id()%>" />
                                <input type="hidden" name="action" value="update" />
                                <button type="submit" class="btn btn-primary"><i class="fa-solid fa-pen-to-square"></i></button>
                            </form>
                        </td>
                    </tr>
                    <%}%>
                </tbody>
            </table>
        </div>
        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Delete Product!!!</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Are you sure for this?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <form action="productdetail" method="POST">
                            <input type="hidden" name="id" id="idForDelete"/>
                            <input type="hidden" name="action" value="delete" />
                            <button type="submit" class="btn btn-primary">Delete</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
