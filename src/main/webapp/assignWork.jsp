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
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
		<link href="style.css" rel="stylesheet">
		
	</head>
	<body>
	<div class="container">
	<h1>Proyectos de empleado</h1>
		<%
			/* comprueba que el usuario está logeado */
			if(session.getAttribute("employeeSession")== null){
				response.sendRedirect("error.jsp?mgs=No estás logeado");
				return;
			}
			
			/* comprueba si el trabajo está finalizado */
			if(request.getParameter("stop")!= null){
				
				int timeStart = (int) session.getAttribute("timeStart");
				int timeEnd = (int)(new Date().getTime()/1000);
				int totalTime = timeEnd - timeStart;
				if(session.getAttribute("totalTimeSession")!= null){					
					totalTime += (int) session.getAttribute("totalTimeSession");
				}

				try{
					Project project = RepositoryDB.find(Project.class,(int)session.getAttribute("projectSession")); 
					Employee employee = (Employee)session.getAttribute("employeeSession");
					
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
				
				session.removeAttribute("timeStart");
				session.removeAttribute("projectSession");
				
			}
			
			/* comprueba si el trabajo acaba de comenzar */
			if(request.getParameter("submit")!= null || request.getParameter("resume")!= null){
				int date = (int)(new Date().getTime()/1000);
				session.setAttribute("timeStart", date);
				if(request.getParameter("resume")== null){		
					session.setAttribute("projectSession", Integer.parseInt(request.getParameter("project")));
				}
				
				%>
				<div class="row">
					<div class="col">
						<form action="assignWork.jsp" method="post">
							<button type="submit" name="pause" class="btn btn-warning">Pausar</button>
						</form>
					</div>
					<div class="col">
						<form action="assignWork.jsp" method="post">
							<button type="submit" name="stop" class="btn btn-danger">Finalizar</button>
						</form>
					</div>
				</div>
				<%
			/* comprueba si el trabajo está pausado */
			}else if(request.getParameter("pause")!= null){
				int timeStart = (int) session.getAttribute("timeStart");
				int timeEnd = (int)(new Date().getTime()/1000);
				session.setAttribute("totalTimeSession", timeEnd - timeStart);
			%>
				<div class="row">
					<div class="col">					
						<form action="assignWork.jsp" method="post">
							<button type="submit" name="resume" class="btn btn-success">Reanudar</button>
						</form>
					</div>
					<div class="col">
						<form action="assignWork.jsp" method="post">
							<button type="submit" name="stop" class="btn btn-danger">Finalizar</button>
						</form>
					</div>
				</div>
			<%
			}%>
		</div>
	</body>
</html>