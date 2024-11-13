<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>  


<% String doc = request.getParameter("doc").trim(); %>
<% String idVendedor = request.getParameter("vendedor"); %>



<%
    

    Statement st = null;
    ResultSet rs = null;
    String val = "";
    try {

        st = new Conexao().conectar().createStatement();
        if (idVendedor != null && !idVendedor.equals("0")) {
            
            rs = st.executeQuery("SELECT * FROM vendedores where id = '" + idVendedor + "'");
        } else {
            rs = st.executeQuery("SELECT * FROM vendedores where doc = '" + doc + "' order by id desc");
        }
        
        
        while (rs.next()) {

            out.print(rs.getString(2));
            out.print(",");
            out.print(rs.getString(4));
            val = "1";    
        }
        
        if(val.equals("")){
            out.print("0");
        }
        
    } catch (Exception e) {
        out.print(e);
    }
%>
