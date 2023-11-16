<%@page import="com.jacaranda.repository.RepositoryDB"%>
<%@page import="com.jacaranda.model.Employee"%>
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
			ArrayList<Employee> result = null;
			
			try{
				result = (ArrayList<Employee>) RepositoryDB.findAll(Employee.class);
			}catch(Exception e){
				
			}
			
			Employee employee = (Employee) session.getAttribute("employeeSession");
			
		%>
		
		
		<table>
			<thead>
				<th>Id</th>
				<th>Nombre</th>
				<th>Apellidos</th>
				<th>Email</th>
				<th>Género</th>
				<th>Nacimiento</th>
				<th>Nombre Compañia</th>
			</thead>
			
			<tbody>
			<%for (Employee e: result){%>
			<tr>
				<td><%=e.getId() %></td>
				<td><%=e.getFirstName() %></td>
				<td><%=e.getLastName() %></td>
				<td><%=e.getEmail() %></td>
				<td><%=e.getGender() %>
				<td><%=e.getDateOfBirth() %></td>
				<td><%=e.getCompany().getName() %></td>
			</tr>
		<%}
			%>
	
			</tbody>
		</table>
		
		
	</body>
</html>