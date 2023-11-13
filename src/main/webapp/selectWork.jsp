<%@page import="java.util.Enumeration"%>
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
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
		<link href="style.css" rel="stylesheet">
	</head>
	<body>
		<div class="container">
		<div class="row">
			<div class="col text-center">
				<h1>Gestión de trabajos</h1>
			</div>
		</div>
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
		if(request.getParameter("start")!= null && session.getAttribute("workingSession")== null){			
			int timeStart = (int)(new Date().getTime()/1000);
		
			Enumeration<String> parameterNames = request.getParameterNames();
			
			while (parameterNames.hasMoreElements()){
				String aux = parameterNames.nextElement();
				if(!aux.equals("start")){					
					working.put(aux, timeStart);						
				}
			}
			session.setAttribute("workingSession", working);
			
		}else if(request.getParameter("start")!= null && session.getAttribute("workingSession")!= null){
			int timeStart = (int)(new Date().getTime()/1000);
			working = (HashMap<String, Integer>) session.getAttribute("workingSession");
			Enumeration<String> parameterNames = request.getParameterNames();
			while (parameterNames.hasMoreElements()){
				String aux = parameterNames.nextElement();
				if(!aux.equals("start")){					
					working.put(aux, timeStart);						
				}
			}
			
			session.setAttribute("workingSession", working);
		} 
		
		/* Miro si se ha pulsado parar algun trabajo */
		if(request.getParameter("stop")!= null){		
			
			working = (HashMap<String, Integer>) session.getAttribute("workingSession");
			
			int timeStop = (int)(new Date().getTime()/1000);
			Enumeration<String> parameterNames = request.getParameterNames();
			while (parameterNames.hasMoreElements()){
				String aux = parameterNames.nextElement();
				if(!aux.equals("stop")){					
					int totalTime = timeStop - working.get(aux).intValue();											
					try{
						employee = (Employee)session.getAttribute("employeeSession");
						List<CompanyProject> companyProyects = employee.getCompany().getCompanyProject();
						Project project = new Project();
						for(CompanyProject cp: companyProjects){
							if(cp.getProject().getName().equals(aux)){
								project = cp.getProject();
							}
						}
						
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
					working.remove(aux);						
				}
			}				
				session.setAttribute("workingSession", working);
			}
	
	/* miro si hay algun trabajo en proceso actualmente */
	if(session.getAttribute("workingSession")!= null){
		working = (HashMap<String, Integer>) session.getAttribute("workingSession");
		%>
		<div class="row">
			<div class="col text-center">
				<h2>Trabajos no empezados</h2>
				<ul>
					<form action="selectWork.jsp">
						<%for(CompanyProject companyProject: companyProjects){
							if(!working.containsKey(companyProject.getProject().getName())){
						%>
							<li>
								<%=companyProject.getProject().getName() %>
								<input type="checkbox" class="form-check-input" name="<%=companyProject.getProject().getName() %>" value="<%=companyProject.getProject().getName() %>">
							</li>
								<%
								}
							}%>
						<button type="submit" name="start" class="btn btn-success">Empezar</button>
					</form>
				</ul> 
			</div>
			<div class="col text-center">
				<h2>Trabajos en proceso</h2>
				<ul>
					<form action="selectWork.jsp">
						<%for(String key: working.keySet()){ %>
						<li>
							<%=key %>
							<input type="checkbox" class="form-check-input" name="<%=key %>" value="<%=key %>">
						</li>
						<%} %>
						<button type="submit" name="stop" class="btn btn-danger">Terminar</button>
					</form>
				</ul> 
			</div>
		</div>

	<%}else{%>
	<div class="row">
		<div class="col text-center">
			<h2>Seleccionar proyecto</h2>
			<ul>
				<form action="selectWork.jsp">
					<%for(CompanyProject companyProject: companyProjects){ %>
					<li>
						<%=companyProject.getProject().getName() %>
						<input class="form-check-input" type="checkbox" name="<%=companyProject.getProject().getName() %>" value="<%=companyProject.getProject().getName() %>">
					</li>
					<%} %>
					<button type="submit" name="start" class="btn btn-success">Empezar</button>
				</form>
			</ul> 
		</div>
	</div>
		<%} %>
		
		
		</div>
	</body>
</html>