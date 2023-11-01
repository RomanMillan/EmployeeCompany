<%@page import="com.jacaranda.model.CompanyProject"%>
<%@page import="java.sql.Date"%>
<%@page import="com.jacaranda.model.Project"%>
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
		ArrayList<Company> companies = null;
		ArrayList<Project> projects = null;
		try{
			companies = (ArrayList<Company>) RepositoryDB.findAll(Company.class);
			projects = (ArrayList<Project>) RepositoryDB.findAll(Project.class);
		}catch(Exception e){
			
		}
		
		if(request.getParameter("submit")!= null){
			int idCompany = Integer.parseInt(request.getParameter("idCompany"));
			int idProject = Integer.parseInt(request.getParameter("idProject"));
			Date begin = Date.valueOf(request.getParameter("begin"));
			Date end = Date.valueOf(request.getParameter("end"));
			
			CompanyProject cP = new CompanyProject();
			Company companyObj = RepositoryDB.find(Company.class, idCompany);
			Project projectObj = RepositoryDB.find(Project.class, idProject);
			
			cP.setCompany(companyObj);
			cP.setProject(projectObj);
			cP.setBegin(begin);
			cP.setEnd(end);
			
			try{
				RepositoryDB.add(cP);
				
			}catch(Exception e){
							
			}
			
		}
		
		
		%>
		<h1>Añadir Proyecto a una Empresa</h1>
		<form action="addCompanyProject.jsp" method="post">
			<label>Empresa</label>
			<select name="idCompany">
			<%for(Company company : companies){ %>
				<option value="<%=company.getId()%>"><%=company.getName() %></option>
			<%} %>
			</select> <br>
			<label>Proyecto</label>
			<select name="idProject">
			<%for(Project project : projects){ %>
				<option value="<%=project.getId()%>"><%=project.getName() %></option>
			<%} %>
			</select><br>
			<label>Inicio</label>
			<input type="date" name="begin"><br>
			<label>Fin</label>
			<input type="date" name="end"><br>
			<button type="submit" name="submit">Añadir</button>
		</form>
		
	</body>
</html>