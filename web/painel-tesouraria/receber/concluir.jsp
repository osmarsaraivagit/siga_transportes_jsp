<%@page import="util.Config"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>  

<% 
    String cpfUsuario = (String) session.getAttribute("cpfUsuario");
    String id = request.getParameter("id");

%>

<%
    Statement st = null;
    ResultSet rs = null;

    try {

        st = new Conexao().conectar().createStatement();
        String tipo = "";
        String valor = "";
        String corretor = "";
        double valorCorretor = 0;
        double valorCaixa = 0;
        
        
        rs = st.executeQuery("SELECT * FROM contas_receber where id = '"+id+"' ");
        while (rs.next()) {
            tipo = rs.getString(5);
            valor = rs.getString(2);
            corretor = rs.getString(6);
            
            valorCorretor = Double.parseDouble(valor) * new Config().comissaoCorretores;
            valorCaixa = Double.parseDouble(valor) * new Config().comissaoImobiliaria;
           
           
        }

       st.executeUpdate("UPDATE contas_receber set pago = 'Sim' where id = '" + id + "'");
       st.executeUpdate("INSERT INTO entradas (valor, tesoureiro, corretor, valor_corretor, valor_caixa, data, tipo) values ('" + valor + "', '" + cpfUsuario + "', '" + corretor + "', '" + valorCorretor + "', '" + valorCaixa + "', curDate(), '"+tipo+"' )");
       st.executeUpdate("INSERT INTO movimentacoes (tipo, movimento, valor, tesoureiro, data) values ('Entrada', '"+tipo+"', '" + valorCaixa + "', '" + cpfUsuario + "', curDate())");

        out.print("Editado com Sucesso!!");

    } catch (Exception e) {
        out.print(e);
    }

%>