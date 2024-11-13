<% String pag = "vendedores";%>

<%@page import="util.Upload" %>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>



<%
    Statement st = null;
    ResultSet rs = null;

    Statement st2 = null;
    ResultSet rs2 = null;

    String cpfUsuario = (String) session.getAttribute("cpfUsuario");

%>




<!-- DataTales Example -->
<div class="card shadow mb-4">

    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                    <tr>
                        <th>Nome</th>
                        <th>Tipo</th>
                        <th>CPF/CNPJ</th>
                        <th>Telefone</th>
                        <th>Endereço</th>
                        <th>Corretor</th>
                    </tr>
                </thead>

                <tbody>

                    <%
                        try {
                            String nome = "";
                            String cpf = "";
                            String telefone = "";
                            String tipo = "";
                            String endereco = "";
                            String corretor = "";
                            String nomeCorretor = "";

                            String id = "";

                            st = new Conexao().conectar().createStatement();
                            st2 = new Conexao().conectar().createStatement();
                            rs = st.executeQuery("SELECT * FROM vendedores order by nome asc ");
                            while (rs.next()) {
                                nome = rs.getString(2);
                                cpf = rs.getString(4);
                                telefone = rs.getString(5);
                                tipo = rs.getString(3);
                                endereco = rs.getString(6);
                                corretor = rs.getString(7);

                                id = rs.getString(1);

                                rs2 = st2.executeQuery("SELECT * FROM corretores where cpf = '" + corretor + "' ");
                                while (rs2.next()) {
                                    nomeCorretor = rs2.getString(2);

                                }
                    %>

                    <tr>
                        <td><%=nome%></td>
                        <td><%=tipo%></td>
                        <td><%=cpf%></td>
                        <td><%=telefone%></td>

                        <td><%=endereco%></td>

                        <td><%=nomeCorretor%></td>
                    </tr>

                    <%  }
                        } catch (Exception e) {
                            out.print(e);
                        }
                    %>





                </tbody>
            </table>
        </div>
    </div>
</div>





<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.11/jquery.mask.min.js"></script>

<script src="../../js/mascara.js"></script>