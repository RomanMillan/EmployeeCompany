<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@page import="com.jacaranda.model.Company"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.jacaranda.repository.RepositoryDB"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Sign up</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
		<link href="style.css" rel="stylesheet">
	</head>
	<body>
		
		<%
			ArrayList<Company> companies = (ArrayList<Company>) RepositoryDB.findAll(Company.class);
			String error = "";
			
			/* comprueba si el usuario ha hecho submit */
			if(request.getParameter("submitAdd")!= null){
				/* obtenemos todos los datos */
				String firstName = request.getParameter("firstName");
				String lastName = request.getParameter("lastName");
				String email = request.getParameter("email");
				String gender = request.getParameter("gender");
				String dateOfBirth = request.getParameter("dateOfBirth");
				String idCompany = request.getParameter("idCompany");
				String password = request.getParameter("password");
				String confirmPassword = request.getParameter("confirmPassword");
				
				if(firstName == "" || lastName == "" || email == "" || gender == "" || dateOfBirth == "" 
						|| idCompany == "" || password == "" || confirmPassword == ""){
					error = "Los campos no pueden estár vacíos";
					
				}else if(!password.equals(confirmPassword)){
					error = "La contraseña no coincide";
				}else{
					try{
						
						Company company = RepositoryDB.find(Company.class, Integer.parseInt(idCompany));
						String encrypt = DigestUtils.md5Hex(password);
						
						Employee employee = new Employee();
						employee.setFirstName(firstName);
						employee.setLastName(lastName);
						employee.setEmail(email);
						employee.setGender(gender);
						employee.setDateOfBirth(dateOfBirth);
						employee.setCompany(company);
						employee.setAdmin('0');
						employee.setPassword(encrypt);
						
						RepositoryDB.add(employee);
						
						response.sendRedirect("login.jsp");
						return;
					}catch(Exception e){
						System.out.print(e);
					}
				}
				
				if(error != ""){
				%>
					<div class="alert alert-danger" role="alert">
				  		<%=error %>
					</div>
			  <%}else{ 
					
				}
			}
			%>
		<div class="container">
			<h1>Crear Cuenta de trabajador</h1>
			<form action="signup.jsp" method="post">
				<label>ID</label>
				<input type="text" name="id" readonly class="form-control"> <br>
				<label>Nombre</label>
				<input type="text" name="firstName" class="form-control"> <br>
				<label>Apellidos</label>
				<input type="text" name="lastName" class="form-control"> <br>
				<label>correo</label>
				<input type="email" name="email" class="form-control"> <br>
				<label>Sexo</label>
				<select name="gender" class="form-select">
					<option value="Male">Masculino</option>
					<option value="Female">Femenino</option>
				</select> <br>
				<label>Nacimiento</label>
				<input type="date" name="dateOfBirth" class="form-control"> <br>
				<label>Empresa</label>
					<select name="idCompany"  class="form-select">
						<%for(Company company : companies){ %>
						<option value="<%=company.getId() %>"><%=company.getName() %></option>
						<%} %>
					</select> <br>
				<label>contaseña</label>
				<input type="password" name="password" class="form-control"> <br>
				<label>contaseña</label>
				<input type="password" name="confirmPassword" class="form-control"> <br>
				<button type="submit" name="submitAdd" class="btn btn-success">Crear</button>
			</form>
		</div>
	</body>
</html>