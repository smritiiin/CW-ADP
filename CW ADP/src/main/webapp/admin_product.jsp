<%
if(session.getAttribute("current_user") != null){
	int isAdmin = (int) session.getAttribute("current_user");
	if (isAdmin != 1){
		
		session.setAttribute("credential", "You are not Admin!! No Access");
		response.sendRedirect("login.jsp");
		return;
	}
}
else{
	session.setAttribute("credential","Please login first!!");
	response.sendRedirect("login.jsp");
}

	
	String name = (String) session.getAttribute("name");
	String email = (String) session.getAttribute("email");
%>



<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.productOperation.product" %>
<%@ page import="com.productOperation.*" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin  Products</title>


    <!-- Font awesome link-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    <!--css link-->
    <link rel="stylesheet" href="css/admin_style.css">
</head>
<body>

<header class="header">

    <div class="flex">

        <a href="admin.jsp" class="logo">Admin<span>Panel</span></a>

        <nav class="navbar">
            <a href="admin.jsp">Home</a>
            <a href="#">Products</a>
            <a href="admin_order.jsp">Orders</a>
            
        </nav>

        <div class="icons">
            <div id="menu-btn" class="fas fa-bars"></div>
            <div id="user-btn" class="fas fa-user"></div>
        </div>
        
        <div class="account-box">
            <p>username: <span><%= name %></span></p>
            <p>email: <span><%= email %></span></p>
            <a href="logout" class="delete-btn">logout</a>
        </div>
    </div>
</header>

<!--Header Ends-->

<section class="add-products">

    <h1 class="title">Shop Products</h1>
    <form action="addProduct" method="post" enctype="multipart/form-data">
    	<%@include file="Message/AlertMessage.jsp"%>
        <h3>Add Product</h3>
        <input type="text" name="p_name" class="box" placeholder="enter product name" required>
        <input type="number" name="p_price" class="box" placeholder="enter product price" required>
        <input type="number" name="p_quantity" class="box" placeholder="enter product quantity" required>
        <select name="p_category" class="box">
        	<option value="Men">Mens Wear</option>
        	<option value="Women">Womens Wear</option>
        	<option value="children">Children Wear</option>
        </select>        
        <input type="file" name="p_image" accept="image/jpg, image/jpeg, image/png"  class="box" placeholder="enter product name" required>
        <input type="submit" value="add product" name="add_product" class="btn">
    </form>

</section>

<!--Show products-->


<section class="show-products">
	
		<div class="box-container">
		<%
        ProductDao productDao = new ProductDao();
        List<product> productList = productDao.getAllProducts();
        for (product product : productList) {
    	%>
	        <div class="box">	
	            <img src="images/<%= product.getP_image() %>" alt="<%= product.getP_name() %>">
	            <div class="name"><%= product.getP_name() %></div>
	            <div class="price">Rs<%= product.getP_price() %> /-</div>
	            <a href="admin_updateProductForm.jsp?p_id=<%= product.getP_id() %>"  class="option-btn update-btn">update</a>
	            <form action="deleteProduct" method="post">
       				<input type="hidden" name="delete_p_id" value="<%= product.getP_id() %>">
        			<button type="submit" class="delete-btn">delete</button>
    			</form>
	        </div>
	        
	     <%
        }
    	%>
    	</div>
	
</section>


<script src="js/admin.js"></script>

</body>
</html>