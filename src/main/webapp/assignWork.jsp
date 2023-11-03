<%@page import="com.jacaranda.model.Project"%>
<%@page import="com.jacaranda.model.EmployeeProject"%>
<%@page import="com.jacaranda.repository.RepositoryDB"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="com.jacaranda.model.CompanyProject"%>
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
			/* comprueba que el usuario está logeado */
			if(session.getAttribute("employeeSession")== null){
				response.sendRedirect("error.jsp?mgs=No estás logeado");
				return;
			}
			
			/* comprueba si el trabajo está finalizado */
			if(request.getParameter("stop")!= null && request.getParameter("submit")== null){
				
				int timeStart = (int) session.getAttribute("timeStart");
				int timeEnd = (int)(new Date().getTime()/1000);
				int totalTime = timeEnd - timeStart;
				/* int idProject = Integer.parseInt(session.getAttribute("projectSession").toString()); */

				try{
					Project project = RepositoryDB.find(Project.class,(int)session.getAttribute("projectSession")); 
					
					EmployeeProject employeeProject = new EmployeeProject();
					employeeProject.setEmployee((Employee)session.getAttribute("employeeSession"));
					employeeProject.setTimeWorked(totalTime/60);
					employeeProject.setProject(project);
					
					RepositoryDB.add(employeeProject);
					
				}catch(Exception e){
					response.sendRedirect("error.jsp?mgs=Error al intentar agregar tarea finalizada");
					return;			
				}
				
				session.removeAttribute("timeStart");
				session.removeAttribute("projectSession");
			}
		
			/* comprueba si el trabajo acaba de comenzar */
			if(request.getParameter("submit")!= null){
				int date = (int)(new Date().getTime()/1000);
				session.setAttribute("timeStart", date);
				session.setAttribute("projectSession", Integer.parseInt(request.getParameter("project")));
				%>
				<form action="assignWork.jsp" method="post">
					<button type="submit" name="stop">Finalizar</button>
				</form>
			<%
			}else{			
				Employee employee = null;
				List<CompanyProject> companyProjects = null;
				try{
					employee = (Employee) session.getAttribute("employeeSession");
					companyProjects = employee.getCompany().getCompanyProject();
					
				}catch(Exception e){
					response.sendRedirect("error.jsp?mgs=Error al cargar los datos");
					return;
				}
			
				%>
					<form action="assignWork.jsp" method="post">
						<select name="project">
							<%for(CompanyProject companyProject: companyProjects){ %>
							<option value="<%=companyProject.getProject().getId()%>"><%=companyProject.getProject().getName() %></option>
							<%} %>
						</select>
						<button type="submit" name="submit">Empezar</button>
					</form>
			<%}%>
		
	</body>
</html>