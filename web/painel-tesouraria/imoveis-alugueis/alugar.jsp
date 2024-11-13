<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>  

<%
    String id = request.getParameter("id");
    String doc = request.getParameter("doc");
    String datapgto = request.getParameter("datapgto");
    String inicio = request.getParameter("inicio");
    String fim = request.getParameter("final");

%>

<%
    Statement st = null;
    ResultSet rs = null;

    try {
        
        if(datapgto.equals("")){
            out.print("Escolha um Data para Pagamento");
            return;
        }
        
        if(inicio.equals("")){
            out.print("Informe a data Inicial do Contrato");
            return;
        }
        
        if(fim.equals("")){
            out.print("Informe a data Final do contrato");
            return;
        }
        
        st = new Conexao().conectar().createStatement();
        st.executeUpdate("UPDATE alugueis set ativo = 'Sim', data_pgto = '"+datapgto+"', data_inicio = '"+inicio+"', data_final = '"+fim+"', inquilino = '"+doc+"' where id = '" + id + "' ");
       

        out.print("Editado com Sucesso!!");

    } catch (Exception e) {
        out.print(e);
    }

%>