<%@page import="util.Upload" %>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>


<%

    Statement st = null;
    ResultSet rs = null;

    String cpfUsuario = (String) session.getAttribute("cpfUsuario");

    String titulo = "";
    String descricao = "";
    String data = "";
    String hora = "";
    String imovel = "";
    
    int visitas = 0;

    String id = "";
    String antigo = "";
    String antigo2 = "";

    titulo = request.getParameter("titulo");
    descricao = request.getParameter("descricao");
    data = request.getParameter("data");
    hora = request.getParameter("hora");
    imovel = request.getParameter("imovel");

    //recuperar dados para edição
    antigo = request.getParameter("antigo");
    antigo2 = request.getParameter("antigo2");
    id = request.getParameter("txtid");

    st = new Conexao().conectar().createStatement();

    //verificar se o id do imóvel existe
    if (!imovel.equals("")) {
        rs = st.executeQuery("SELECT * FROM imoveis where id = '" + imovel + "' ");
        
        
        String visit = "";
         while (rs.next()) {
            visit = rs.getString(11); 
            visitas = Integer.parseInt(visit) + 1;
         }
         
        if (rs.last() == false) {
            out.print("Id do Imóvel não Cadastrado");
            return;
        }
        
                  
        
    }

    //INSERIR OS DADOS NO BANCO DE DADOS
    try {

        //verificar se o campo é vazio
        if (titulo.equals("")) {
            out.print("Preencha o Campo Titulo!!");
            return;
        }

        if (descricao.equals("")) {
            out.print("Preencha o Campo Descrição!!");
            return;
        }

        if (data.equals("")) {
            out.print("Preencha a Data!!");
            return;
        }

        //VERIFICAR SE JA EXISTE UM REGISTRO COM A MESMA DATA E HORA
        if (!hora.equals(antigo) || !data.equals(antigo2)) {
            rs = st.executeQuery("SELECT * FROM tarefas where data = '" + data + "' and hora = '" + hora + "' ");

            while (rs.next()) {
                rs.getRow();
                if (rs.getRow() > 0) {
                    out.print("Horário Indisponível!");
                    return;
                }
            }
        }

        if (id.equals("")) {

            st.executeUpdate("INSERT into tarefas (titulo, descricao, data, hora, id_imovel, corretor, status) values ('" + titulo + "', '" + descricao + "' , '" + data + "' , '" + hora + "', '" + imovel + "', '" + cpfUsuario + "', '')");
            st.executeUpdate("UPDATE imoveis SET visitas = '" + visitas + "' WHERE id = '" + imovel + "'");

        } else {

            st.executeUpdate("UPDATE tarefas SET titulo = '" + titulo + "', descricao = '" + descricao + "', data = '" + data + "', hora = '" + hora + "', id_imovel = '" + imovel + "' WHERE id = '" + id + "'");

        }

        out.print("Salvo com Sucesso!!");
    } catch (Exception e) {
        out.print(e);
    }


%>