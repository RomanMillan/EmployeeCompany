<%@page import="com.jacaranda.model.Employee"%>
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
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
		<link href="style.css" rel="stylesheet">
		
	</head>
	<body>	
	<div class="container">
	<h1>Ingresar</h1>
		<%
			if(request.getParameter("closeSession") != null){
				session.invalidate();
			}else if(request.getParameter("submit") != null){
				String username = request.getParameter("username");
				String password = request.getParameter("password");
				
				if(username != "" && password != ""){
					try{						
						Employee employee = RepositoryDB.find(Employee.class, Integer.parseInt(username));
						if(employee.getPassword().equals(password)){
							session.setAttribute("employeeSession", employee);
							response.sendRedirect("listCompany.jsp");
							if(employee.getAdmin() == '1'){
								session.setAttribute("admin", true);
							}
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
				<input type="number" name="username" class="form-control"> <br>
				<label>Contraseña</label>
				<input type="password" name="password" class="form-control"><br>
				<button type="submit" name="submit" class="btn btn-success">Ingresar</button>
			</form>
		</div>
	</div>
	</body>
</html>