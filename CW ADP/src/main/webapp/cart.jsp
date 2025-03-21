<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>    
<%@ page import="com.cart.*" %> 
<%@ page import="com.cart.CartItem" %>
<%@ page import="com.productOperation.*" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
    
<%
if(session.getAttribute("current_user") != null){
	int isAdmin = (int) session.getAttribute("current_user");
	if (isAdmin == 1){
		
		session.setAttribute("credential", "You are Admin!! No access to this page");
		response.sendRedirect("admin.jsp");
		return;
	}
}


%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>cart</title>

  <!-- Font awesome link-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    <!--css link-->
    <link rel="stylesheet" href="css/style.css">

</head>
<body>
	<%@include file= "navbar.jsp" %>
	<section class="shopping-cart">
	
		<div class="heading">
			<h3>shopping cart</h3>
			<p><a href="index.jsp">home</a>/cart</p>
		</div>
		
		
		<div class="box-container">
		<c:if test="${empty cart or empty cart.items}">	
			<div class="btn" style="text-align: center; pointer-events: none;">Your Cart is Empty.</div>
		</c:if>
		<%
		Cart c = (Cart) session.getAttribute("cart");
		if(c != null || c.getItems().isEmpty() == false){
	        List<CartItem> cartItems = c.getItems();
	        for (CartItem cartItem : cartItems) {
	            product product = cartItem.getProduct();
		
		%>
		
			<div class="box">
				<a href=""></a>
				<img src="images/<%= product.getP_image() %>" alt="">
				<div class="name"><%= product.getP_name() %></div>
				<div class="price">Rs<%= product.getP_price()%> /-</div>
				<form method="post" action="UpdateCart">
					<input type="hidden" name="cart_id" value="<%= product.getP_id()%>">
					<input type="number" min="1" name="quantity" value="<%= cartItem.getQuantity()%>"> 
					<input type="submit" name="update_cart" value="update" class="option-btn">
				</form>
				<form action="removeCartProduct" method="get">
					<input type="hidden" name="cart_id" value="<%= product.getP_id() %>">
                    <input type="submit" name="delete_cart" value="remove" class="delete-btn">
				</form>
				<div class="sub-total">sub total : <span>Rs<%= product.getP_price() * cartItem.getQuantity()%> /-</span></div>
			</div>
		<%
        	}
		}
		%>	
		</div>
		
		<!-- 
		<div style="margin-top: 2rem; text-align:center;">
			<a href="" class="delete-btn">delete all</a>
		</div>  -->
		
		<div class="cart-total">
		<c:set var="grandTotal" value="${cart.getTotalPrice()}" />
			<p>grand total : <span>Rs ${grandTotal} /-</span></p>
			<div class="flex">
				<a href="shop.jsp" class="option-btn">continue shopping</a>
				<a href="" class="btn">proceed to checkout</a>
			</div>
		</div>
	</section>
	
	<%@include file="footer.jsp"%>
</body>
</html>