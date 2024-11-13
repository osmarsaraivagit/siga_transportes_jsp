<%@page import="java.time.LocalDate"%>
<% String pag = "tarefas";%>

<%@page import="util.Upload" %>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>



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
                        <th>Titulo</th>
                        <th>Descrição</th>
                        <th>Data</th>
                        <th>Hora</th>
                        <th>Corretor</th>

                    </tr>
                </thead>

                <tbody>

                    <%
                        try {

                            String titulo = "";
                            String descricao = "";
                            String data = "";
                            String hora = "";
                            String imovel = "";
                            String corretor = "";
                            String nomeCorretor = "";

                            st = new Conexao().conectar().createStatement();
                            st2 = new Conexao().conectar().createStatement();
                            rs = st.executeQuery("SELECT * FROM tarefas order by id desc ");
                            while (rs.next()) {
                                titulo = rs.getString(2);
                                descricao = rs.getString(3);
                                data = rs.getString(4);
                                hora = rs.getString(5);
                                imovel = rs.getString(6);
                                corretor = rs.getString(7);

                                id = rs.getString(1);

                                String[] dataSeparada = data.split("-");
                                data = dataSeparada[2] + "/" + dataSeparada[1] + "/" + dataSeparada[0];
                                
                                
                                rs2 = st2.executeQuery("SELECT * FROM corretores where cpf = '"+corretor+"' ");
                                while (rs2.next()) {
                                    nomeCorretor = rs2.getString(2);
                                }

                    %>

                    <tr>
                        <td><%=titulo%></td>
                        <td><%=descricao%></td>
                        <td><%=data%></td>
                        <td><%=hora%></td>
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

<script type="text/javascript">
    $(document).ready(function () {
        $('#dataTable').dataTable({
            "ordering": false
        })

    });
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.11/jquery.mask.min.js"></script>

<script src="../../js/mascara.js"></script>