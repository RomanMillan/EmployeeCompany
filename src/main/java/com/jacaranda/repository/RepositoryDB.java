package com.jacaranda.repository;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.jacaranda.utility.ConnectionDB;

public class RepositoryDB {

	public static <T> T find(Class<T> c, int id) throws Exception {
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
	
	public static <T> T find(Class<T> c, String id) throws Exception {
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

	public static Object add(Object obj) throws Exception {
		Transaction transation = null;
		Session session = null;
		try {
			session = ConnectionDB.getSessionFactory().openSession();
			transation = session.beginTransaction();
		} catch (Exception e) {
			throw new Exception("error en la BD");
		}
		
		try {
//			Hay que poner persist() ya que el merge() solo busca una id
			session.persist(obj);
			transation.commit();
		} catch (Exception e) {
			transation.rollback();
			throw new Exception("error al añadir");
		}
		
		return obj;
	}
	
	public static Object delete(Object obj) throws Exception {
		Transaction transation = null;
		Session session = null;
		try {
			session = ConnectionDB.getSessionFactory().openSession();
			transation = session.beginTransaction();
		} catch (Exception e) {
			throw new Exception("error en la BD");
		}
		
		try {
			session.remove(obj);
			transation.commit();
		} catch (Exception e) {
			transation.rollback();
			throw new Exception("error al borrar");
		}
		
		return obj;
	}
	
	
}
