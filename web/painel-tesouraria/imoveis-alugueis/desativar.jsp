<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>  

<% String id = request.getParameter("id"); %>

<%
    Statement st = null;
    ResultSet rs = null;

    try {
        
        st = new Conexao().conectar().createStatement();
        st.executeUpdate("UPDATE alugueis set ativo = 'Não', data = curDate(), data_pgto = null, data_inicio = null, data_final = null, inquilino = '' where id = '" + id + "'");
       

        out.print("Desativado com Sucesso!!");

    } catch (Exception e) {
        out.print(e);
    }

%>