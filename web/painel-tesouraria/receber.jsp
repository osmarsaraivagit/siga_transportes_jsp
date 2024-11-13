<%@page import="java.time.*"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%> 

<% String pag = "receber";%>

<%@page import="util.Upload" %>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>





<%
    Statement st = null;
    Statement st2 = null;
    Statement st3 = null;
    Statement st4 = null;

    ResultSet rs = null;
    ResultSet rs2 = null;
    ResultSet rs3 = null;
    ResultSet rs4 = null;
    
    //SE PREFERIREM PODEM COLOCAR ESTAS COBRANÇAS NA INDEX, ASSIM QUALQUER PÁGINA QUE ACESSAR FARÁ ESSA VERIFICAÇÃO
        
    //verificar se há cobranças pendentes para hoje
    st = new Conexao().conectar().createStatement();
    st2 = new Conexao().conectar().createStatement();
    st3 = new Conexao().conectar().createStatement();
    st4 = new Conexao().conectar().createStatement();

    String id = "";
    Date dataHoje = new Date(System.currentTimeMillis());
    String classe = "";

    try {
        rs = st.executeQuery("SELECT * FROM alugueis where ativo = 'Sim' and data_pgto <= curDate() and data_final >= curDate() ");
        while (rs.next()) {

            String data_pgto = "";
            String id_al = "";
            String corretor = "";
            String valor = "";
            String doc = "";
            String nomeInquilino = "";

            String id_im = "";
            String cpfVendedor = "";
            String nomeVendedor = "";

            data_pgto = rs.getString(7);
            valor = rs.getString(4);
            corretor = rs.getString(3);
            doc = rs.getString(10);
            id_al = rs.getString(1);
            id_im = rs.getString(2);

            rs2 = st2.executeQuery("SELECT * FROM compradores where doc = '" + doc + "' ");
            while (rs2.next()) {
                nomeInquilino = rs2.getString(2);
            }

            rs3 = st3.executeQuery("SELECT * FROM imoveis where id = '" + id_im + "' ");
            while (rs3.next()) {
                cpfVendedor = rs3.getString(2);
            }

            rs4 = st4.executeQuery("SELECT * FROM vendedores where doc = '" + cpfVendedor + "' ");
            while (rs4.next()) {
                nomeVendedor = rs4.getString(2);
            }

            //out.print(nomeInquilino);
            DateTimeFormatter formatador = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate dataDigitada = LocalDate.parse(data_pgto, formatador);
            LocalDate dataSomada = dataDigitada.plus(Period.ofDays(30));
            data_pgto = formatador.format(dataSomada);
            //out.print("Somado:   " + data_pgto);

            //atualizando a data pagamento para 30 dias posterior
            st2.executeUpdate("UPDATE alugueis set data_pgto = '" + data_pgto + "' where id = '" + id_al + "' ");

            //Lançar a cobrança na tabela contas a receber e na tabela contas Pagar
            st2.executeUpdate("INSERT into contas_receber (valor, titulo, descricao, tipo, corretor, data, pago, cliente) values ('" + valor + "', 'Pagamento Aluguel', '" + nomeInquilino + "', 'Aluguel', '" + corretor + "', curDate(), 'Não', '" + doc + "'  )");
            st2.executeUpdate("INSERT into contas_pagar (valor, titulo, descricao, pago, tesoureiro, data) values ('" + valor + "', 'Aluguel', '" + nomeVendedor + "', 'Não', '', curDate()  )");

        }

    } catch (Exception e) {
        out.print(e);
    }

%>





<!-- DataTales Example -->
<div class="card shadow mb-4">

    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                    <tr>
                        <th>Tipo</th>
                        <th>Valor</th>
                        <th>Cliente</th>
                        <th>Telefone</th>
                        <th>Corretor</th>
                        <th>Data PGTO</th>
                        <th>Dar Baixa</th>

                    </tr>
                </thead>

                <tbody>

                    <%                        try {
                            String tipo = "";
                            String valor = "";
                            String cliente = "";
                            String nomeCliente = "";
                            String corretor = "";
                            String dataPgto = "";
                            String nomeCorretor = "";
                            String telefoneCliente = "";

                            st = new Conexao().conectar().createStatement();
                            st2 = new Conexao().conectar().createStatement();
                            st3 = new Conexao().conectar().createStatement();
                            rs = st.executeQuery("SELECT * FROM contas_receber where pago = 'Não' order by data asc ");
                            while (rs.next()) {
                                tipo = rs.getString(5);
                                valor = rs.getString(2);
                                cliente = rs.getString(9);
                                dataPgto = rs.getString(7);
                                corretor = rs.getString(6);

                                double vlr = 0;
                                vlr = Double.parseDouble(valor);
                                valor = (NumberFormat.getCurrencyInstance().format(vlr));

                                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                                java.util.Date minhaData = format.parse(dataPgto);

                                String[] dataSeparada = dataPgto.split("-");
                                dataPgto = dataSeparada[2] + "/" + dataSeparada[1] + "/" + dataSeparada[0];

                                id = rs.getString(1);

                                rs2 = st2.executeQuery("SELECT * FROM compradores where doc = '" + cliente + "' ");
                                while (rs2.next()) {
                                    telefoneCliente = rs2.getString(5);
                                    nomeCliente = rs2.getString(2);
                                }

                                rs3 = st3.executeQuery("SELECT * FROM corretores where cpf = '" + corretor + "' ");
                                while (rs3.next()) {
                                    nomeCorretor = rs3.getString(2);
                                }

                                if (minhaData.before(dataHoje)) {
                                    classe = "text-danger";
                                } else {
                                    classe = "text-success";
                                }
                    %>

                    <tr>
                        <td><%=tipo%></td>
                        <td><%=valor%></td>
                        <td><%=nomeCliente%></td>
                        <td><%=telefoneCliente%></td>
                        <td><%=nomeCorretor%></td>
                        <td><%=dataPgto%></td>

                        <td align="center">
                            <a href="index.jsp?pag=<%=pag%>&funcao=baixa&id=<%=id%>&valor=<%=valor%>" class='<%=classe%> mr-1' title='Dar Baixa'><i class='far fa-check-square'></i></a>

                        </td>
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




<div class="modal" id="modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Baixar Pagamento</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <%
                    String valor2 = "";
                    valor2 = request.getParameter("valor");
                %>
                <p>Este valor de <%=valor2%> Reais já foi recebido por você?</p>

                <div align="center" id="mensagem_excluir" class="">

                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal" id="btn-cancelar-excluir">Cancelar</button>
                <form method="post">
                    <%id = request.getParameter("id");%>
                    <input type="hidden" id="id"  name="id" value="<%=id%>" required>

                    <button type="button" id="btn-deletar" name="btn-deletar" class="btn btn-success">Confirmar</button>
                </form>
            </div>
        </div>
    </div>
</div>






<%    if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("baixa")) {

        out.print("<script>$('#modal').modal('show');</script>");
    }

%>                    






<!--AJAX PARA EXCLUSÃO DOS DADOS -->
<script type="text/javascript">
    $(document).ready(function () {
        var pag = "<%=pag%>";
        $('#btn-deletar').click(function (event) {
            event.preventDefault();

            $.ajax({
                url: pag + "/concluir.jsp",
                method: "post",
                data: $('form').serialize(),
                dataType: "text",
                success: function (mensagem) {

                    if (mensagem.trim() === 'Editado com Sucesso!!') {


                        $('#btn-cancelar-excluir').click();
                        window.location = "index.jsp?pag=" + pag;
                    }

                    $('#mensagem_excluir').text(mensagem)



                },

            })
        })
    })
</script>


<script type="text/javascript">
    $(document).ready(function () {
        $('#dataTable').dataTable({
            "ordering": false
        })

    });
</script>


<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.11/jquery.mask.min.js"></script>

<script src="../../js/mascara.js"></script>