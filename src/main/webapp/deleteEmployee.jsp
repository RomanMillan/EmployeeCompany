<%@page import="java.util.ArrayList"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@page import="com.jacaranda.repository.RepositoryDB"%>
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
	
		Employee employee = new Employee();

		if(request.getParameter("submit") != null){
			String id = (String) request.getParameter("id");
			String firstName = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String email = request.getParameter("email");
			String gender = request.getParameter("gender");
			String birthdate = request.getParameter("birthdate");
			String company = request.getParameter("company");
			
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
			
			RepositoryDB.delete(employee);
			
			
					
		}else{			
			String idEmployee = request.getParameter("idEmployee");
			try{
				employee = RepositoryDB.find(Employee.class, Integer.parseInt(idEmployee));
			}catch(Exception e){
				
			}
		}
		
	%>
	
	<div class="container">
			<h1>Borrar Empleado</h1>
			
			<form class="form" action="deleteEmployee.jsp" method="post">
				<label>Id</label>
				<input type="text" name="id" class="form-control" value="<%=employee.getId() %>" readonly="readonly"> <br>
				<label>Nombre</label>
				<input type="text" name="firstName" class="form-control" value="<%=employee.getFirstName() %>" > <br>
				<label>Apellidos</label>
				<input type="text" name="lastName" class="form-control" value="<%=employee.getLastName() %>"><br>
				<label>Correo</label>
				<input type="email" name="email" class="form-control" value="<%=employee.getEmail() %>"><br>
				<label>Sexo</label>
				<input type="text" name="gender" value="<%=employee.getGender()%>"> <br>
				<label>Fecha de nacimiento</label>
				<input type="date" name="birthdate" class="form-control" value="<%=employee.getDateOfBirth() %>"><br>
				<label>Empresa</label>
				<input type="text" name="company" value="<%=employee.getCompany().getId()%>"><br>
				<button type="submit" name="submit" class="btn btn-danger">Borrar</button>
			</form>
		</div>
	</body>
</html>