<%@page import="com.jacaranda.model.Employee"%>
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
			if(session.getAttribute("employeeSession")== null){
				response.sendRedirect("error.jsp?mgs=No estás logeado");
				return;
			}
		
			Employee employee = (Employee) session.getAttribute("employeeSession");
			
		%>
		
			<div class="container">
				<form>
					<select>
						<%for() %>
						<option></option>
					</select>
					<button type="submit" name="submit">Empezar</button>
				</form>
			</div>
		
	</body>
</html>