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


<% String pag = "movimentacoes";%>


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

    double entradas = 0;
    double saidas = 0;
    double total = 0;
    
    String valorEntradas = "";
    String valorSaidas = "";
    String valorTotal = "";
    String classeValor = "";


%>





<!-- DataTales Example -->
<div class="card shadow mb-4">

    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                    <tr>
                        <th>Tipo</th>
                        <th>Movimento</th>
                        <th>Valor</th>
                        <th>Tesoureiro</th>
                        <th>Data</th>


                    </tr>
                </thead>

                <tbody>

                    <%                        try {
                            rs = st.executeQuery("SELECT * FROM movimentacoes order by id desc ");
                            while (rs.next()) {

                                String data = "";
                                String tipo = "";
                                String movimento = "";
                                String valor = "";
                                String tesoureiro = "";
                                String nomeTesoureiro = "";

                                data = rs.getString(6);
                                valor = rs.getString(4);
                                tipo = rs.getString(2);
                                movimento = rs.getString(3);
                                tesoureiro = rs.getString(5);

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
                        <td><%=tipo%></td>
                        <td><%=movimento%></td>
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


        <% //TOTALIZANDO VALORES
            rs = st.executeQuery("SELECT * FROM movimentacoes where data = curDate()");
            String vlr = "";
            String tip = "";
            while (rs.next()) {

                
                
                tip = rs.getString(2);
                if (tip.equals("Entrada")) {
                    vlr = rs.getString(4);
                    entradas = entradas + Double.parseDouble(vlr);
                    valorEntradas = (NumberFormat.getCurrencyInstance().format(entradas));
                    
                }else{
                    vlr = rs.getString(4);
                    saidas = saidas + Double.parseDouble(vlr);
                    valorSaidas = (NumberFormat.getCurrencyInstance().format(saidas));
                    
                }
                
                total = entradas - saidas;
                if(total < 0){
                    classeValor = "text-danger";
                }else{
                    classeValor = "text-success";
                }
                
                valorTotal = (NumberFormat.getCurrencyInstance().format(total));
                    
            }
        %>
        <hr class="mt-4">
        <span class="text-muted"><small>Movimentações de Hoje</small></span>
        <hr class="mb-2">

        <div class="row ">
            <div class="col-md-9">
                <span class="mr-4 text-success">Entradas: <%=valorEntradas%></span> 
                <span class="text-danger">Saídas: <%=valorSaidas%></span>

            </div>
            <div class="col-md-3">
                <span class="<%=classeValor%> mr-4">Total: <%=valorTotal%></span> 

            </div>
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