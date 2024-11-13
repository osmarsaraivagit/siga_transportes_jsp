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
    up.setFolderUpload("sistema/img/imoveis");
    
    if (up.formProcess(getServletContext(), request)) {

        try {
          
            id = up.getForm().get("id").toString();
            img = up.getFiles().get(0).toString();
            

        } catch (Exception e) {
            img = "sem-img.jpg";
            
        }
        
        
        //INSERIR OS DADOS NO BANCO DE DADOS
        try {
             st = new Conexao().conectar().createStatement();
             st.executeUpdate("INSERT INTO imagens (id_imovel, imagem) values ('" + id + "', '" + img + "') ");
                    
              
            out.print("Salvo com Sucesso!!");
        } catch (Exception e) {
            out.print(e);
        }

    }

%>