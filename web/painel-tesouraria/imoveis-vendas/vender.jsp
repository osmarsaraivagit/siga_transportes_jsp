<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>  

<%
    String id = request.getParameter("id");
    String doc = request.getParameter("doc");
    String datapgto = request.getParameter("datapgto");


%>

<%    Statement st = null;
    ResultSet rs = null;

    Statement st2 = null;
    ResultSet rs2 = null;

    String corretor = "";
    String valor = "";

    String nomeInquilino = "";

    try {

        st = new Conexao().conectar().createStatement();
        st2 = new Conexao().conectar().createStatement();

        if (datapgto.equals("")) {
            out.print("Escolha um Data para Pagamento");
            return;
        }

        rs = st.executeQuery("SELECT * FROM vendas where id = '" + id + "' ");
        while (rs.next()) {

            valor = rs.getString(4);
            corretor = rs.getString(3);

            rs2 = st2.executeQuery("SELECT * FROM compradores where doc = '" + doc + "' ");
            while (rs2.next()) {
                nomeInquilino = rs2.getString(2);
            }
        }

        st.executeUpdate("UPDATE vendas set pago = 'Sim', data_pgto = '" + datapgto + "', comprador = '" + doc + "' where id = '" + id + "' ");

        //Lançar a cobrança na tabela contas a receber
        st2.executeUpdate("INSERT into contas_receber (valor, titulo, descricao, tipo, corretor, data, pago, cliente) values ('" + valor + "', 'Pagamento Venda', '" + nomeInquilino + "', 'Venda', '" + corretor + "', curDate(), 'Não', '" + doc + "'  )");

        out.print("Editado com Sucesso!!");

    } catch (Exception e) {
        out.print(e);
    }

%>