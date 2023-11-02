<%@page import="com.jacaranda.model.User"%>
<%@page import="com.jacaranda.repository.RepositoryDB"%>
<%@page import="com.jacaranda.utility.ConnectionDB"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>	
		
		<%
			if(request.getParameter("submit") != null){
				String username = request.getParameter("username");
				String password = request.getParameter("password");
				
				if(username != "" && password != ""){
					try{						
						User user = RepositoryDB.find(User.class, username);
						if(user.getPassword().equals(password)){
							session.setAttribute("userId", username);
							response.sendRedirect("listCompany.jsp");
						}else{
							response.sendRedirect("error.jsp?msg=contraseña erronea");
						}
					}catch(Exception e){
						response.sendRedirect("error.jsp?msg=usuario no encontrado");
					}
				}
				
			}
		%>
		
		<div class="container">
			<form action="login.jsp" method="post">
				<label>Usuario</label>
				<input type="text" name="username">
				<label>Contraseña</label>
				<input type="password" name="password">
				<button type="submit" name="submit">Ingresar</button>
			</form>
		</div>
	
	</body>
</html>