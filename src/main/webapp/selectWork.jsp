<%@page import="com.jacaranda.utility.ConnectionDB"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.jacaranda.model.EmployeeProject"%>
<%@page import="com.jacaranda.repository.RepositoryDB"%>
<%@page import="com.jacaranda.model.Project"%>
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
		
		/* Miro si el empleado está logeado */
		try{
			employee = (Employee) session.getAttribute("employeeSession");
			companyProjects = employee.getCompany().getCompanyProject();
			
		}catch(Exception e){
			response.sendRedirect("error.jsp?mgs=Error al cargar los datos");
			return;
		}
	
		HashMap<String, Integer> working = new HashMap<String, Integer>();
		
		/* Miro si se ha puesto a empezar a trabajar */
		if(request.getParameter("start")!= null){			
			int timeStart = (int)(new Date().getTime()/1000);
			for(CompanyProject companyProject: companyProjects){
				String p = request.getParameter(companyProject.getProject().getName());					
				if(p != null){
					working.put(p, timeStart);										
				}
				session.setAttribute("workingSession", working);
			}
		}
		
		/* Miro si se ha pulsado parar algun trabajo */
		if(request.getParameter("stop")!= null){		
			
			working = (HashMap<String, Integer>) session.getAttribute("workingSession");
			
			int timeStop = (int)(new Date().getTime()/1000);
			
			for(CompanyProject companyProject: companyProjects){
				String p = request.getParameter(companyProject.getProject().getName());					
				if(p != null){
					if(working.get(p) != null){
						int totalTime = timeStop - working.get(p).intValue();
						
						try{
							Project project = RepositoryDB.find(Project.class, companyProject.getProject().getId());
							
							employee = (Employee)session.getAttribute("employeeSession");
							
							EmployeeProject employeeProject = new EmployeeProject();
							employeeProject.setEmployee(employee);
							employeeProject.setProject(project);
							
							EmployeeProject newEmployeeProject = RepositoryDB.findEmployeeProject(employeeProject);
							if(newEmployeeProject == null){
								employeeProject.setTimeWorked(totalTime);
								RepositoryDB.add(employeeProject);
							}else{
								newEmployeeProject.setTimeWorked(totalTime + employeeProject.getTimeWorked());
								RepositoryDB.update(newEmployeeProject);
							}
						}catch(Exception e){
							response.sendRedirect("error.jsp?msg=Error al intentar agregar tarea finalizada");
							return;			
						}
						working.remove(p);						
					}
				}	
				}
				session.setAttribute("workingSession", working);
			}
	
	/* miro si hay algun trabajo en proceso actualmente */
	if(session.getAttribute("workingSession")!= null){
		HashMap<String, Integer> workingHM = (HashMap<String, Integer>)	session.getAttribute("workingSession");
		%>
		<h2>Trabajos en proceso</h2>
		<ul>
			<form action="selectWork.jsp">
				<%for(String key: working.keySet()){ %>
				<li>
					<%=key %>
					<input type="checkbox" name="<%=key %>" value="<%=key %>">
				</li>
				<%} %>
				<button type="submit" name="stop">Terminar</button>
			</form>
		</ul> 
	<br> <br>
		<h2>Trabajos no empezados</h2>
		<ul>
			<form action="selectWork.jsp">
				<%for(CompanyProject companyProject: companyProjects){
					if(!workingHM.containsKey(companyProject.getProject().getName())){
				%>
					<li>
						<%=companyProject.getProject().getName() %>
						<input type="checkbox" name="<%=companyProject.getProject().getName() %>" value="<%=companyProject.getProject().getName() %>">
					</li>
						<%
						}
					}%>
				<button type="submit" name="start">start</button>
			</form>
		</ul> 
	<%}else{%>
	<ul>
		<form action="selectWork.jsp">
			<%for(CompanyProject companyProject: companyProjects){ %>
			<li>
				<%=companyProject.getProject().getName() %>
				<input type="checkbox" name="<%=companyProject.getProject().getName() %>" value="<%=companyProject.getProject().getName() %>">
			</li>
			<%} %>
			<button type="submit" name="start">Empezar</button>
		</form>
	</ul> 
		<%} %>
		
		
		
	</body>
</html>