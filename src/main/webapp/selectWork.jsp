<%@page import="java.util.Date"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@page import="com.jacaranda.model.CompanyProject"%>
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
		
		Employee employee = null;
		List<CompanyProject> companyProjects = null;
		try{
			employee = (Employee) session.getAttribute("employeeSession");
			companyProjects = employee.getCompany().getCompanyProject();
			
		}catch(Exception e){
			response.sendRedirect("error.jsp?mgs=Error al cargar los datos");
			return;
		}
		
		
		HashMap<String, Integer> working = new HashMap<String, Integer>();
		if(request.getParameter("submit")!= null){			
			int timeStart = (int)(new Date().getTime()/1000);
			for(CompanyProject companyProject: companyProjects){
				String p = request.getParameter(companyProject.getProject().getName());					
				if(p != null){
					working.put(p, timeStart);										
				}
			}
		
		%>
		<ul>
		<%for(String key: working.keySet()){%>
			<li>
				<%=key %>
				<%=working.get(key).intValue() %>
			</li>
			<%}; %>
		</ul> 
		<%
		}
	
		
	%>
		
			
	
	<ul>
		<form action="selectWork.jsp">
			<%for(CompanyProject companyProject: companyProjects){ %>
			<li>
				<%=companyProject.getProject().getName() %>
				<input type="checkbox" name="<%=companyProject.getProject().getName() %>" value="<%=companyProject.getProject().getName() %>">
			</li>
			<%} %>
			<button type="submit" name="submit">Empezar</button>
		</form>
	</ul> 
		
	</body>
</html>