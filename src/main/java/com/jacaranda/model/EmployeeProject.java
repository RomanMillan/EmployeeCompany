package com.jacaranda.model;

import java.util.Objects;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class EmployeeProject {
	
	@Id
	@ManyToOne
	@JoinColumn(name="id_employee")
	private Employee employee;
	@Id
	@ManyToOne
	@JoinColumn(name="id_project")
	private Project project;
	@Column(name="time_worked")
	private int timeWorked;
	
	
	public Employee getEmployee() {
		return employee;
	}
	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
	public Project getProject() {
		return project;
	}
	public void setProject(Project project) {
		this.project = project;
	}
	public int getTimeWorked() {
		return timeWorked;
	}
	public void setTimeWorked(int timeWorked) {
		this.timeWorked = timeWorked;
	}
	@Override
	public int hashCode() {
		return Objects.hash(employee, project);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		EmployeeProject other = (EmployeeProject) obj;
		return Objects.equals(employee, other.employee) && Objects.equals(project, other.project);
	}
	
	
	

	
	
	

}
