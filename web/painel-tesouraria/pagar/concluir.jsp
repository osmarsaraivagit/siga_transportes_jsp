<%@page import="util.Config"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>  

<%
    String cpfUsuario = (String) session.getAttribute("cpfUsuario");
    String id = request.getParameter("id");

%>

<%    Statement st = null;
    ResultSet rs = null;

    try {

        st = new Conexao().conectar().createStatement();
        String tipo = "";
        String valor = "";
        String corretor = "";
        double valorTotal = 0;
        String titulo = "";

        rs = st.executeQuery("SELECT * FROM contas_pagar where id = '" + id + "' ");
        while (rs.next()) {
            tipo = rs.getString(5);
            valor = rs.getString(2);
            corretor = rs.getString(6);
            titulo = rs.getString(3);

            if (titulo.equals("Aluguel")) {
                valorTotal = new Config().comissaoCorretores + new Config().comissaoImobiliaria;
                valorTotal = Double.parseDouble(valor) - (Double.parseDouble(valor) * valorTotal);

            }else{
                valorTotal = Double.parseDouble(valor);
            }

        }

        st.executeUpdate("UPDATE contas_pagar set pago = 'Sim' where id = '" + id + "'");
        st.executeUpdate("INSERT INTO saidas (valor, tesoureiro, descricao, data) values ('" + valorTotal + "', '" + cpfUsuario + "', '" + titulo + "', curDate())");
        st.executeUpdate("INSERT INTO movimentacoes (tipo, movimento, valor, tesoureiro, data) values ('Saída', '" + titulo + "', '" + valorTotal + "', '" + cpfUsuario + "', curDate())");

        out.print("Editado com Sucesso!!");

    } catch (Exception e) {
        out.print(e);
    }

%>