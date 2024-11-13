<%@page import="java.time.*"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%> 


<%@page import="util.Upload" %>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>


<% String pag = "saidas";%>


<%
    Statement st = null;
    Statement st2 = null;
    Statement st3 = null;

    ResultSet rs = null;
    ResultSet rs2 = null;
    ResultSet rs3 = null;

    //verificar se há cobranças pendentes para hoje
    st = new Conexao().conectar().createStatement();
    st2 = new Conexao().conectar().createStatement();


%>





<!-- DataTales Example -->
<div class="card shadow mb-4">

    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                    <tr>
                        <th>Descrição</th>
                        <th>Valor</th>
                        <th>Tesoureiro</th>
                        <th>Data</th>
                       


                    </tr>
                </thead>

                <tbody>

                    <%                        try {
                            rs = st.executeQuery("SELECT * FROM saidas order by id desc ");
                            while (rs.next()) {

                                String data = "";
                                String descricao = "";
                                String nomeTesoureiro = "";
                                String valor = "";
                                String tesoureiro = "";
                                

                                data = rs.getString(5);
                                valor = rs.getString(2);
                                tesoureiro = rs.getString(3);
                                descricao = rs.getString(4);
                                

                                double vlr = 0;
                             
                                vlr = Double.parseDouble(valor);
                                valor = (NumberFormat.getCurrencyInstance().format(vlr));

                                
                                String[] dataSeparada = data.split("-");
                                data = dataSeparada[2] + "/" + dataSeparada[1] + "/" + dataSeparada[0];

                                rs2 = st2.executeQuery("SELECT * FROM tesoureiros where cpf = '" + tesoureiro + "' ");
                                while (rs2.next()) {
                                    nomeTesoureiro = rs2.getString(2);
                                }


                    %>

                    <tr>
                        <td><%=descricao%></td>
                        <td><%=valor%></td>
                        <td><%=nomeTesoureiro%></td>
                       
                        <td><%=data%></td>



                    </tr>

                    <%              }

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