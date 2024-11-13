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
    String valor = "";

    titulo = request.getParameter("titulo");
    descricao = request.getParameter("descricao");
    valor = request.getParameter("valor");

    //INSERIR OS DADOS NO BANCO DE DADOS
    try {

        //verificar se o campo é vazio
        if (titulo.equals("")) {
            out.print("Preencha o Campo Título!!");
            return;
        }

        //verificar se o campo é vazio
        if (valor.equals("")) {
            out.print("Preencha o Campo Valor!!");
            return;
        }

        st = new Conexao().conectar().createStatement();
        st.executeUpdate("INSERT into contas_pagar (valor, titulo, descricao, pago, tesoureiro, data) values ('" + valor + "', '" + titulo + "', '" + descricao + "', 'Não', '" + cpfUsuario + "', curDate())");

        out.print("Salvo com Sucesso!!");
    } catch (Exception e) {
        out.print(e);
    }


%>