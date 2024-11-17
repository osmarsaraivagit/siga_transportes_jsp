<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="br.com.sigatransportes.util.Upload" %>
<%@page import="br.com.sigatransportes.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%
    Statement st = null;
    ResultSet rs = null;

    String nome = "";
    String cpf = "";
    String email = "";
    String senha = "";
    String nivel = "";
    String foto = null;
    
    
    String id = "";
    String antigo = "";

    Upload up = new Upload();

//definir qual a pasta a ser salva
    up.setFolderUpload("/img/profiles");

    if (up.formProcess(getServletContext(), request)) {

        try {
            
            nome = up.getForm().get("nome").toString();
            cpf = up.getForm().get("cpf").toString();
            email = up.getForm().get("email").toString();
            senha = up.getForm().get("senha").toString();
            nivel = up.getForm().get("nivel").toString();
            id = up.getForm().get("txtid").toString();
            antigo = up.getForm().get("antigo").toString();
            foto = up.getFiles().get(0).toString();
            
            
            
        } catch (Exception e) {
            foto = "sem-foto.jpg";

        }

        //INSERIR OS DADOS NO BANCO DE DADOS
        try {
            
            //verificar se o campo é vazio
            if(nome.equals("")){
                out.print("Preencha o Campo Nome teste!!");
                return;
            }
            
            if(cpf.equals("")){
                out.print("Preencha o Campo CPF!!");
                return;
            }
            
            st = new Conexao().conectar().createStatement();
            
            //VERIFICAR SE JA EXISTE UM REGISTRO COM ESTE DADO NO BANCO
            if(!cpf.equals(antigo)){
                rs = st.executeQuery("SELECT * FROM usuarios where cpf = '" + cpf + "'");
            while (rs.next()) {
                rs.getRow();
                if (rs.getRow() > 0) {
                    out.print("CPF Já Cadastrado!");
                    return;
                }
            }
            }
            
            if(id.equals("")){
                st.executeUpdate("INSERT into usuarios (nome, cpf, email, senha, nivel, foto) values ('" + nome + "', '" + cpf + "' , '" + email + "' , '" + senha + "', '" + nivel + "', '" + foto + "')");
                
            }else{
                if(foto.equals("sem-foto.jpg")){
                    st.executeUpdate("UPDATE usuarios SET nome = '" + nome + "', cpf = '" + cpf + "', email = '" + email + "', senha = '" + senha + "', nivel = '" + nivel + "' WHERE id = '" + id + "'");
                    st.executeUpdate("UPDATE usuarios SET nome = '" + nome + "', cpf = '" + cpf + "', email = '" + email + "' WHERE cpf = '" + antigo + "'");
                }else{
                    st.executeUpdate("UPDATE usuarios SET nome = '" + nome + "', cpf = '" + cpf + "', email = '" + email + "', senha = '" + senha + "', nivel = '" + nivel + "', foto = '" + foto + "' WHERE id = '" + id + "'");
                    st.executeUpdate("UPDATE usuarios SET nome = '" + nome + "', cpf = '" + cpf + "', email = '" + email + "', foto = '" + foto + "' WHERE cpf = '" + antigo + "'");
                }
                
            }
            
            out.print("Salvo com Sucesso!!");
        } catch (Exception e) {
            out.print(e);
        }

    }

%>