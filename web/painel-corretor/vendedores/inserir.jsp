<%@page import="util.Upload" %>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>


<%
       
        Statement st = null;
        ResultSet rs = null;
        
        String cpfUsuario = (String) session.getAttribute("cpfUsuario");
        

        String nome = "";
        String tipo = "";
        String cpf = "";
        String cnpj = "";
        String telefone = "";
        String endereco = "";

        String id = "";
        String antigo = "";
        
        
        nome = request.getParameter("nome");
        tipo = request.getParameter("tipo");
        cpf = request.getParameter("cpf");
        cnpj = request.getParameter("cnpj");
        telefone = request.getParameter("telefone");
        endereco = request.getParameter("endereco");
        
        if(tipo.equals("Juridica")){
            cpf = cnpj;
            
        }
        
        //recuperar dados para edição
        antigo = request.getParameter("antigo");
        id = request.getParameter("txtid");
        
        //INSERIR OS DADOS NO BANCO DE DADOS
        try {

            //verificar se o campo é vazio
            if (nome.equals("")) {
                out.print("Preencha o Campo Nome teste!!");
                return;
            }

            if (cpf.equals("")) {
                out.print("Preencha o Campo CPF!!");
                return;
            }

            st = new Conexao().conectar().createStatement();

            //VERIFICAR SE JA EXISTE UM REGISTRO COM ESTE DADO NO BANCO
            if (!cpf.equals(antigo)) {
                rs = st.executeQuery("SELECT * FROM vendedores where doc = '" + cpf + "' and corretor = '" + cpfUsuario + "' ");
                while (rs.next()) {
                    rs.getRow();
                    if (rs.getRow() > 0) {
                        out.print("CPF Já Cadastrado!");
                        return;
                    }
                }
            }

            if (id.equals("")) {
                
                st.executeUpdate("INSERT into vendedores (nome, tipo_pessoa, doc, telefone, endereco, corretor) values ('" + nome + "', '" + tipo + "' , '" + cpf + "' , '" + telefone + "', '" + endereco + "', '" + cpfUsuario + "')");
                
            } else {
                
                st.executeUpdate("UPDATE vendedores SET nome = '" + nome + "', tipo_pessoa = '" + tipo + "', doc = '" + cpf + "', telefone = '" + telefone + "', endereco = '" + endereco + "' WHERE id = '" + id + "'");
               
            }

            out.print("Salvo com Sucesso!!");
        } catch (Exception e) {
            out.print(e);
        }

    

%>