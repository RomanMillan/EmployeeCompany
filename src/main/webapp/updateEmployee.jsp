<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
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
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
		<link href="style.css" rel="stylesheet">
	</head>
	<body>
		<%
		
			ArrayList<Company> companies = null;
			Employee employee = new Employee();
			
			/* comprueba que el usuario está logeado */
			if(session.getAttribute("employeeSession")== null){
				response.sendRedirect("error.jsp?mgs=No estás logeado");
				return;
			}
			
			try{
				companies = (ArrayList<Company>) RepositoryDB.findAll(Company.class);
			}catch(Exception e){
				
			}
			
	
			if(request.getParameter("submit") != null){
				String id = (String) request.getParameter("id");
				String firstName = request.getParameter("firstName");
				String lastName = request.getParameter("lastName");
				String email = request.getParameter("email");
				String gender = request.getParameter("gender");
				String birthdate = request.getParameter("birthdate");
				String company = request.getParameter("company");
				String admin = request.getParameter("admin");
				String password = request.getParameter("password");
				
				Company companyObj = null;
				try{
					companyObj = RepositoryDB.find(Company.class, Integer.parseInt(company));
				}catch(Exception e){
					System.out.print(e);
				}
				
				employee.setId(Integer.parseInt(id));
				employee.setFirstName(firstName);
				employee.setLastName(lastName);
				employee.setEmail(email);
				employee.setGender(gender);
				employee.setDateOfBirth(birthdate);
				employee.setCompany(companyObj);
				
				/* si no es admin no puede cambiar la contraseña ni el role de admin */
				if(admin == null){
					employee.setAdmin('0');
					Employee employeePassword = (Employee) session.getAttribute("employeeSession");
					employee.setPassword(employeePassword.getPassword());
				}else{
					employee.setAdmin(admin.charAt(0));
					if(!password.equals("")){
						employee.setPassword(DigestUtils.md5Hex(password));						
					}else{
						Employee employeePassword = (Employee) RepositoryDB.find(Employee.class, Integer.parseInt(id));
						employee.setPassword(employeePassword.getPassword());
					}
				}
				
				
				RepositoryDB.update(employee);
						
			}else if(request.getParameter("idEmployee") != null){			
				String idEmployee = request.getParameter("idEmployee");
				try{
					employee = RepositoryDB.find(Employee.class, Integer.parseInt(idEmployee));
				}catch(Exception e){
					
				}
			}else{
				employee = (Employee) session.getAttribute("employeeSession");
			}
			
		%>
		
		<div class="container">
				<h1>Editar Empleado</h1>
				
				<form class="form" action="updateEmployee.jsp" method="post">
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
					  <%if(employee.getGender().equals("Male")){ %>
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
					 <%
					  Employee employeeUser = (Employee) session.getAttribute("employeeSession");
					 if(employeeUser.getAdmin() == '1'){ %>
					 	<label>Admin</label>
						<input type="text" name="admin" class="form-control" value="<%=employee.getAdmin() %>">
						<label>contraseña</label>
						<input type="password" name="password" class="form-control">
					 <%} %>
					<button type="submit" name="submit" class="btn btn-primary">Actualizar</button>
				</form>
				
			</div>
		
	</body>
</html>