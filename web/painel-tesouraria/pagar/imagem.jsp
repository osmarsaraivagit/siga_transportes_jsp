<%@page import="util.Upload" %>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>


<%
       
    Statement st = null;
    ResultSet rs = null;
    
    
    String img = null;
   
    String id = "";

    Upload up = new Upload();
    
    

//definir qual a pasta a ser salva
    up.setFolderUpload("sistema/img/contas");
    
    if (up.formProcess(getServletContext(), request)) {

        try {
          
            id = up.getForm().get("id").toString();
            img = up.getFiles().get(0).toString();
            

        } catch (Exception e) {
            img = "";
            
        }
        
        
        //INSERIR OS DADOS NO BANCO DE DADOS
        try {
             st = new Conexao().conectar().createStatement();
             st.executeUpdate("UPDATE contas_pagar SET foto = '" + img + "' WHERE id = '" + id + "'");
                    
              
            out.print("Salvo com Sucesso!!");
        } catch (Exception e) {
            out.print(e);
        }

    }

%>