<%@page import="com.jacaranda.model.CompanyProject"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@page import="com.jacaranda.repository.RepositoryDB"%>
<%@page import="com.jacaranda.model.Company"%>
<%@page import="java.util.ArrayList"%>
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
		<%
			ArrayList<Company> result = null;
			
			try{
				result = (ArrayList<Company>) RepositoryDB.findAll(Company.class);
			}catch(Exception e){
				
			}
		%>
		
		<%for (Company c: result){
		
			int numberEmployees = c.getEmployees().size();
			int numberProject = c.getCompanyProject().size();
		%>
		<h2>Empresa</h2>
		<table class="table">
			<thead class="thead-dark">
				<tr>
					<th scope="col">Nombre</th>
					<th scope="col">Nº Empleados</th>
					<th scope="col">Nº Proyectos</th>
				<tr>
			</thead>
			
			<tbody>
				<tr>
					<td><%=c.getName() %></td>
					<td><%=numberEmployees %></td>
					<td><%=numberProject %></td>
				</tr>
				<tr class="bg-info">
					<td colspan="3"><b>EMPLEADOS</b></td>
				</tr>
				<tr>
					<td colspan="3">
						<table class="table table-striped">
							<thead>
								<th>Id</th>
								<th>Nombre</th>
								<th>Apellidos</th>
		
							</thead>
							<tbody>
							<%for(Employee e: c.getEmployees()){ %>
								<tr>
									<td><%=e.getId() %></td>
									<td><%=e.getFirstName() %></td>
									<td><%=e.getLastName() %></td>
								</tr>
							<%} %>
							</tbody>
						</table>
					</td>
				</tr>
				<tr class="bg-warning">
					<td colspan="3"><b>PROYECTOS</b></td>
				</tr>
				<tr>
					<td colspan="3">
						<table class="table table-striped">
							<thead>
								<th>Nombre</th>
								<th>Inicio</th>
								<th>Finalización</th>
		
							</thead>
							<tbody>
							<%for(CompanyProject cP: c.getCompanyProject()){ %>
								<tr>
									<td><%=cP.getProject().getName() %></td>
									<td><%=cP.getBegin() %></td>
									<td><%=cP.getEnd() %></td>
								</tr>
							<%} %>
							</tbody>
						</table>
					</td>
				</tr>
			</tbody>
		</table>
		<br>
		<hr/>
				<%}%>
		
		
		</div>
		
	</body>
</html>