<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%> 

<% String pag = "imoveis";%>

<%
    Statement st = null;
    ResultSet rs = null;

    String id = request.getParameter("id");
       

    st = new Conexao().conectar().createStatement();
    rs = st.executeQuery("SELECT * FROM imagens where id_imovel = '" + id + "'");
    
    out.print("<div class='row'>");
    while (rs.next()) {
              
      out.print("<img class='ml-4 mb-2' src='../img/imoveis/" + rs.getString(3) + "' width='70'><a href='#' onClick='deletarImg("+ rs.getString(1) +")'><i class='text-danger fas fa-times ml-1'></i></a>");

    }
    out.print("</div>");
%>



