<%@page import="com.jacaranda.model.Employee"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.jacaranda.model.Company"%>
<%@page import="com.jacaranda.repository.RepositoryDB"%>
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
		<%
			ArrayList<Company> companies = null;
			try{
				companies = (ArrayList<Company>) RepositoryDB.findAll(Company.class);
			}catch(Exception e){
				
			}
			
			if(request.getParameter("submit") != null){
				
				String id = (String) request.getParameter("id");
				String firstName = (String) request.getParameter("firstName");
				String lastName = (String) request.getParameter("lastName");
				String email = (String) request.getParameter("email");
				String gender = (String) request.getParameter("gender");
				String birthdate = (String) request.getParameter("birthdate");
				String company = (String)request.getParameter("company");
				
				try{
					Company c = RepositoryDB.find(Company.class, Integer.parseInt(company));
					
					Employee e = new Employee();
					e.setId(Integer.parseInt(id));
					e.setFirstName(firstName);
					e.setLastName(lastName);
					e.setEmail(email);
					e.setGender(gender);
					e.setDateOfBirth(birthdate);
					e.setCompany(c);
					
					RepositoryDB.add(Employee.class, e);
					
				}catch(Exception e){
					
				}
			}
			
		%>
	
		<div class="container">
			<h1>Añadir Empleado</h1>
			
			<form class="form" action="addEmployee.jsp" method="post">
				<label>Id</label>
				<input type="text" name="id" class="form-control"> <br>
				<label>Nombre</label>
				<input type="text" name="firstName" class="form-control"> <br>
				<label>Apellidos</label>
				<input type="text" name="lastName" class="form-control"><br>
				<label>Correo</label>
				<input type="email" name="email" class="form-control"><br>
				<div class="input-group mb-3">
				  <div class="input-group-prepend">
				    <label class="input-group-text">Sexo</label>
				  </div>
				  <select name="gender" class="custom-select">
				    <option value="Male">Masculino</option>
				    <option value="Female">Femenino</option>
				  </select>
				</div>
				<label>Fecha de nacimiento</label>
				<input type="date" name="birthdate" class="form-control">
				<div class="input-group mb-3">
				  <div class="input-group-prepend">
				    <label class="input-group-text">Compañia</label>
				  </div>
				  <select name="company" class="custom-select">
				  <%for(Company c: companies){ %>
				    <option value="<%=c.getId() %>"><%=c.getName() %></option>
				   <%} %>
				  </select>
				 </div>
				<button type="submit" name="submit" class="btn btn-primary">Añadir</button>
			</form>
		</div>
	</body>
</html>