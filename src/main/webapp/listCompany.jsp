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
	</head>
	<body>
		<%
			ArrayList<Company> result = null;
			
			try{
				result = (ArrayList<Company>) RepositoryDB.findAll(Company.class);
			}catch(Exception e){
				
			}
		%>
		
		
		<table>
			<thead>
				<th>Nombre</th>
				<th>Nº Empleado</th>
				<th>Nº Proyecto</th>
			</thead>
			
			<tbody>
			<%for (Company c: result){
			
				int numberEmployees =  c.getEmployees().size();
				int numberProject = c.getCompanyProject().size();
			%>
			<tr>
				<td><%=c.getName() %></td>
				<td><%=numberEmployees %></td>
				<td><%=numberProject %></td>
				<td>
					<table>
						<thead>
							<th>Id</th>
							<th>Nombre</th>
							<th>Apellidos</th>
							<th>Email</th>
							<th>Género</th>
							<th>Nacimiento</th>
						</thead>
						<tbody>
						<%for(Employee e: c.getEmployees()){ %>
							<tr>
								<td><%=e.getId() %></td>
								<td><%=e.getFirstName() %></td>
								<td><%=e.getLastName() %></td>
								<td><%=e.getEmail() %></td>
								<td><%=e.getGender() %>
								<td><%=e.getDateOfBirth() %></td>
							</tr>
						<%} %>
						</tbody>
					</table>
				</td>
			</tr>
		<%}%>
	
			</tbody>
		</table>
	</body>
</html>