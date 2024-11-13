<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>  

<% String id = request.getParameter("id"); %>

<%
    String quantImoveis = "";
    int totalImoveis = 0;
    String tipo = "";

    Statement st = null;
    ResultSet rs = null;

    try {

        //recuperar a quantidade de imoveis do tipo
        st = new Conexao().conectar().createStatement();

        rs = st.executeQuery("SELECT * FROM imoveis where id = '"+id+"' ");
        while (rs.next()) {

            tipo = rs.getString(6);
        }

        rs = st.executeQuery("SELECT * FROM tipos where id = '" + tipo + "' ");

        while (rs.next()) {
            quantImoveis = rs.getString(4);
        }
        totalImoveis = Integer.parseInt(quantImoveis) - 1;

        st = new Conexao().conectar().createStatement();

        st.executeUpdate("DELETE from imoveis where id = '" + id + "'");
        st.executeUpdate("UPDATE tipos SET imoveis = '" + totalImoveis + "' WHERE id = '" + tipo + "'");

        out.print("Excluído com Sucesso!!");

    } catch (Exception e) {
        out.print(e);
    }

%>