<%@page import="util.Upload" %>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>



<%
    Statement st = null;
    ResultSet rs = null;

    String nome = "";
    String cpf = "";
    String email = "";
    String senha = "";
    String imagem = null;
    String descricao = "";
    String facebook = "";
    String twitter = "";
    String endereco = "";
    String telefone = "";
    
    String id = "";
    String antigo = "";

    Upload up = new Upload();

//definir qual a pasta a ser salva
    up.setFolderUpload("sistema/img/profiles");

    if (up.formProcess(getServletContext(), request)) {

        try {
            
            nome = up.getForm().get("nome").toString();
            cpf = up.getForm().get("cpf").toString();
            email = up.getForm().get("email").toString();
            senha = up.getForm().get("senha").toString();
            descricao = up.getForm().get("descricao").toString();
            twitter = up.getForm().get("twitter").toString();
            facebook = up.getForm().get("facebook").toString();
            endereco = up.getForm().get("endereco").toString();
            telefone = up.getForm().get("telefone").toString();
            
            id = up.getForm().get("txtid").toString();
            antigo = up.getForm().get("antigo").toString();
            
            imagem = up.getFiles().get(0).toString();
            
            
            
        } catch (Exception e) {
            imagem = "sem-foto.jpg";
            
        }

        //INSERIR OS DADOS NO BANCO DE DADOS
        try {
            
            //verificar se o campo � vazio
            if(nome.equals("")){
                out.print("Preencha o Campo Nome!!");
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
                    out.print("CPF J� Cadastrado!");
                    return;
                }
            }
            }
            
            
                if(imagem.equals("sem-foto.jpg")){
                    st.executeUpdate("UPDATE usuarios SET nome = '" + nome + "', cpf = '" + cpf + "', email = '" + email + "', senha = '" + senha + "' WHERE id = '" + id + "'");
                    st.executeUpdate("UPDATE corretores SET nome = '" + nome + "', cpf = '" + cpf + "', telefone = '" + telefone + "', email = '" + email + "', endereco = '" + endereco + "', descricao = '" + descricao + "', twitter = '" + twitter + "', facebook = '" + facebook + "' WHERE cpf = '" + antigo + "'");
                }else{
                    st.executeUpdate("UPDATE usuarios SET nome = '" + nome + "', cpf = '" + cpf + "', email = '" + email + "', senha = '" + senha + "', foto = '" + imagem + "' WHERE id = '" + id + "'");
                    st.executeUpdate("UPDATE corretores SET nome = '" + nome + "', cpf = '" + cpf + "', telefone = '" + telefone + "', email = '" + email + "', endereco = '" + endereco + "', descricao = '" + descricao + "', twitter = '" + twitter + "', facebook = '" + facebook + "', foto = '" + imagem + "' WHERE cpf = '" + antigo + "'");
                }
                
            
            
            out.print("Salvo com Sucesso!!");
        } catch (Exception e) {
            out.print(e);
        }

    }

%>