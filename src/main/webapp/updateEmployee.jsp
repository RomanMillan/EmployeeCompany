<%@page import="java.util.ArrayList"%>
<%@page import="com.jacaranda.repository.RepositoryDB"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@page import="com.jacaranda.model.Company"%>
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
	
		ArrayList<Company> companies = null;
		try{
			companies = (ArrayList<Company>) RepositoryDB.findAll(Company.class);
		}catch(Exception e){
			
		}
		
		Employee employee = null;
		String idEmployee = request.getParameter("idEmployee");
		try{
			employee = RepositoryDB.find(Employee.class, Integer.parseInt(idEmployee));
		}catch(Exception e){
			
		}
		
		if(request.getParameter("submit") != null){
			String id = (String) request.getParameter("id");
			String firstName = request.getParameter("firstName");
			String lastName =  request.getParameter("lastName");
			String email = (String) request.getParameter("email");
			String gender = (String) request.getParameter("gender");
			String birthdate = (String) request.getParameter("birthdate");
			String company = (String)request.getParameter("company");
			
			Company c = RepositoryDB.find(Company.class, Integer.getInteger(company));
			
			employee.setId(Integer.parseInt(id));
			employee.setFirstName(firstName);
			employee.setLastName(lastName);
			employee.setEmail(email);
			employee.setGender(gender);
			employee.setDateOfBirth(birthdate);
			employee.setCompany(c);
			
			RepositoryDB.add(Employee.class, employee);
			
		}
		
	%>
	
	<div class="container">
			<h1>Editar Empleado</h1>
			
			<form class="form" action="addEmployee.jsp" method="post">
				<label>Id</label>
				<input type="text" name="id" class="form-control" value="<%=employee.getId() %>" readonly="readonly"> <br>
				<label>Nombre</label>
				<input type="text" name="firstName" class="form-control" value="<%=employee.getFirstName() %>" > <br>
				<label>Apellidos</label>
				<input type="text" name="lastName" class="form-control" value="<%=employee.getLastName() %>"><br>
				<label>Correo</label>
				<input type="email" name="email" class="form-control" value="<%=employee.getEmail() %>"><br>
				<div class="input-group mb-3">
				  <div class="input-group-prepend">
				    <label class="input-group-text">Sexo</label>
				  </div>
				  <select name="gender" class="custom-select">
				  <%if(employee.getGender().equals("Masculino")){ %>
				   	 <option value="Male" selected="selected">Masculino</option>
				   	  <option value="Female">Femenino</option>
				    <%}else{%>
				   	 <option value="Male">Masculino</option>
				  	  <option value="Female" selected="selected">Femenino</option>
				    <% }%>
				  </select>
				</div>
				<label>Fecha de nacimiento</label>
				<input type="date" name="birthdate" class="form-control" value="<%=employee.getDateOfBirth() %>">
				
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