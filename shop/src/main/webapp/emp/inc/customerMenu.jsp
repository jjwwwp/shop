<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%
	HashMap<String, Object> loginCsMember = null;
	if(session.getAttribute("loginCustomer") != null) {
		loginCsMember = (HashMap<String, Object>)(session.getAttribute("loginCustomer"));	
	}
%>
