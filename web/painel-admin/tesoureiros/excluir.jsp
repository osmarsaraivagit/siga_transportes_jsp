<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>  

<% String id = request.getParameter("id"); %>

<%
    Statement st = null;
    ResultSet rs = null;

    try {
        
        st = new Conexao().conectar().createStatement();
        

        //recuperar o cpf do usuario para exclus�o
        String cpf = "";
        rs = st.executeQuery("SELECT * FROM tesoureiros where id = '" + id + "' ");
        while (rs.next()) {
            cpf = rs.getString(3);
            
        }
        
        st.executeUpdate("DELETE from tesoureiros where id = '" + id + "'");
        st.executeUpdate("DELETE from usuarios where cpf = '" + cpf + "'");

        out.print("Exclu�do com Sucesso!!");

    } catch (Exception e) {
        out.print(e);
    }

%>