<%@page import="util.Upload" %>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>


<%
       
        Statement st = null;
        ResultSet rs = null;
        
        String cpfUsuario = (String) session.getAttribute("cpfUsuario");
        

        String nome = "";
       

        String id = "";
        String antigo = "";

        nome = request.getParameter("nome");
        
        
        //recuperar dados para edi��o
        antigo = request.getParameter("antigo");
        id = request.getParameter("txtid");
        
        //INSERIR OS DADOS NO BANCO DE DADOS
        try {

            //verificar se o campo � vazio
            if (nome.equals("")) {
                out.print("Preencha o Campo Nome teste!!");
                return;
            }


            st = new Conexao().conectar().createStatement();

            //VERIFICAR SE JA EXISTE UM REGISTRO COM ESTE DADO NO BANCO
            if (!nome.equals(antigo)) {
                rs = st.executeQuery("SELECT * FROM cidades where nome = '" + nome + "' ");
                while (rs.next()) {
                    rs.getRow();
                    if (rs.getRow() > 0) {
                        out.print("Cidade J� Cadastrada!");
                        return;
                    }
                }
            }

            if (id.equals("")) {
                
                st.executeUpdate("INSERT into cidades (nome) values ('" + nome + "')");
                
            } else {
                
                st.executeUpdate("UPDATE cidades SET nome = '" + nome + "' WHERE id = '" + id + "'");
               
            }

            out.print("Salvo com Sucesso!!");
        } catch (Exception e) {
            out.print(e);
        }

    

%>