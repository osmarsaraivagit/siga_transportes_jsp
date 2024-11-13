<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%> 

<%
    Statement st = null;
    ResultSet rs = null;
    
String bairro = request.getParameter("txtbairro");
String cidade = request.getParameter("txtcidade");
String id = request.getParameter("txtid");

%>



<%

out.print("<div class='form-group'>"
                                +"<label >Bairro</label>"
                                +"<select class='form-control' name='bairro' id='bairro'>" );

                                    
                                        String nome4 = "";
                                        st = new Conexao().conectar().createStatement();
                                        //recuperar o nome do campo para mostrar de inicio no select
                                        if (!id.equals("")) {

                                            rs = st.executeQuery("SELECT * FROM bairros where id = '" + bairro + "' ");
                                            while (rs.next()) {
                                                nome4 = rs.getString(2);
                                            }
                                            
                                                out.print("<option value='" + bairro + "'>" + nome4 + "</option>");
                                            
                                            

                                        }

                                        
                                        if(bairro.equals("")){
                                            
                                        }
                                        rs = st.executeQuery("SELECT * FROM bairros where cidade = '" + cidade + "' order by nome asc");

                                        while (rs.next()) {
                                            if (!nome4.equals(rs.getString(2))) {
                                                out.print("<option value='" + rs.getString(1) + "'>" + rs.getString(2) + "</option>");
                                            }

                                        }

                                    

        out.print("</select> </div>"); %>


