<%@page import="java.time.LocalDate"%>
<% String pag = "tarefas";%>

<%@page import="util.Upload" %>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>
<%@page import="java.text.NumberFormat"%> 



<%
    String cpfUsuario = (String) session.getAttribute("cpfUsuario");
    Statement st = null;
    ResultSet rs = null;

    Statement st2 = null;
    ResultSet rs2 = null;

    String id = "";

%>






<!-- DataTales Example -->
<div class="card shadow mb-4">

    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                    <tr>
                        <th>Imóvel</th>
                        <th>Corretor</th>
                        <th>Valor</th>
                        <th>Ativo</th>
                        <th>Data</th>

                    </tr>
                </thead>

                <tbody>

                    <%                        try {

                            String imovel = "";
                            String corretor = "";
                            String data = "";
                            String valor = "";
                            String ativo = "";

                            String nomeCorretor = "";

                            st = new Conexao().conectar().createStatement();
                            st2 = new Conexao().conectar().createStatement();
                            rs = st.executeQuery("SELECT * FROM alugueis order by id desc ");
                            while (rs.next()) {
                                imovel = rs.getString(2);
                                corretor = rs.getString(3);
                                data = rs.getString(6);
                                valor = rs.getString(4);
                                ativo = rs.getString(5);

                                id = rs.getString(1);

                                String[] dataSeparada = data.split("-");
                                data = dataSeparada[2] + "/" + dataSeparada[1] + "/" + dataSeparada[0];

                                rs2 = st2.executeQuery("SELECT * FROM corretores where cpf = '" + corretor + "' ");
                                while (rs2.next()) {
                                    nomeCorretor = rs2.getString(2);
                                }

                                double vlr = 0;
                                vlr = Double.parseDouble(valor);
                                valor = (NumberFormat.getCurrencyInstance().format(vlr));


                    %>

                    <tr>
                        <td><%=imovel%></td>
                        <td><%=nomeCorretor%></td>
                        <td><%=valor%></td>
                        <td><%=ativo%></td>
                        <td><%=data%></td>



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

<script type="text/javascript">
    $(document).ready(function () {
        $('#dataTable').dataTable({
            "ordering": false
        })

    });
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.11/jquery.mask.min.js"></script>

<script src="../../js/mascara.js"></script>