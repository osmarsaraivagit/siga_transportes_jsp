<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="br.com.sigatransportes.util.Upload" %>
<%@page import="br.com.sigatransportes.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>

<% String id = request.getParameter("id"); %>

<%
    Statement st = null;
    ResultSet rs = null;

    try {
        
        st = new Conexao().conectar().createStatement();
        

        //recuperar o cpf do usuario para exclusão
        String cpf = "";
        rs = st.executeQuery("SELECT * FROM usuarios where id = '" + id + "' ");
        while (rs.next()) {
            cpf = rs.getString(3);
            
        }
        
        st.executeUpdate("DELETE from usuarios where id = '" + id + "'");
        st.executeUpdate("DELETE from usuarios where cpf = '" + cpf + "'");

        out.print("Excluído com Sucesso!!");

    } catch (Exception e) {
        out.print(e);
    }

%>