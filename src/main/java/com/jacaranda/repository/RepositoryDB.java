package com.jacaranda.repository;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.jacaranda.utility.ConnectionDB;

public class RepositoryDB {

	public static <T> T find(Class<T> c, int id) throws Exception {
		Transaction transation = null;
		Session session = null;
		T result = null;
		try {
			session = ConnectionDB.getSessionFactory().openSession();
		} catch (Exception e) {
			throw new Exception("error en la BD");
		}
		
		try {
			result = session.find(c,id);
		} catch (Exception e) {
			throw new Exception("error al obtener la entidad");
		}
		
		return result;
	}
	
	
	public static <T> List<T> findAll(Class<T> c) throws Exception {
		Transaction transation = null;
		Session session = null;
		List<T> resultList = null;
		try {
			session = ConnectionDB.getSessionFactory().openSession();
		} catch (Exception e) {
			throw new Exception("error en la BD");
		}
		
		try {
			resultList = (List<T>) session.createSelectionQuery("From " + c.getName()).getResultList();
		} catch (Exception e) {
			throw new Exception("error al obtener la entidad");
		}
		
		return resultList;
	}
	
}
