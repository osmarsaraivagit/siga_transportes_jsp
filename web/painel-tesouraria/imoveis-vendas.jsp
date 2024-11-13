<% String pag = "imoveis-vendas";%>

<%@page import="util.Upload" %>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>
<%@page import="java.text.NumberFormat"%> 


<%
    Statement st = null;
    ResultSet rs = null;

    Statement st2 = null;
    ResultSet rs2 = null;

    Statement st3 = null;
    ResultSet rs3 = null;

    String id = "";
    String id_imovel = "";

%>


<!-- DataTales Example -->
<div class="card shadow mb-4">

    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                    <tr>
                        <th>Código</th>
                        <th>Corretor</th>
                        <th>Título</th>
                        <th>Valor</th>

                        <th>Vender Imóvel</th>
                    </tr>
                </thead>

                <tbody>

                    <%                        try {
                            String titulo = "";
                            String corretor = "";
                            String valor = "";
                            String nomeCorretor = "";

                            st = new Conexao().conectar().createStatement();
                            rs = st.executeQuery("SELECT * FROM vendas where pago = 'Não' order by id ");
                            while (rs.next()) {
                                id_imovel = rs.getString(2);
                                corretor = rs.getString(3);
                                valor = rs.getString(4);
                                id = rs.getString(1);

                                double vlr = 0;
                                vlr = Double.parseDouble(valor);
                                valor = (NumberFormat.getCurrencyInstance().format(vlr));

                                st2 = new Conexao().conectar().createStatement();
                                rs2 = st2.executeQuery("SELECT * FROM corretores where cpf = '" + corretor + "' ");
                                while (rs2.next()) {
                                    nomeCorretor = rs2.getString(2);
                                }

                                st3 = new Conexao().conectar().createStatement();
                                rs3 = st3.executeQuery("SELECT * FROM imoveis where id = '" + id_imovel + "' ");
                                while (rs3.next()) {
                                    titulo = rs3.getString(4);
                                }


                    %>

                    <tr>
                        <td><%=id_imovel%></td>
                        <td><%=nomeCorretor%></td>
                        <td><%=titulo%></td>
                        <td><%=valor%></td>

                        <td>
                            <a href="index.jsp?pag=<%=pag%>&funcao=modal&id=<%=id%>&idimov=<%=id_imovel%>" class='text-primary mr-1' title='Vender Imóvel'><i class='far fa-check-square'></i></a>

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
                <h5 class="modal-title">Dados para Venda</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="form" method="POST" >
                <div class="modal-body">



                    <div class="form-group">
                        <label >Comprador</label>
                        <select class="form-control" name="vendedor" id="vendedor">

                            <%
                                id_imovel = request.getParameter("idimov");
                                id = request.getParameter("id");
                                String cpfCorretor = "";
                                st = new Conexao().conectar().createStatement();
                                rs = st.executeQuery("SELECT * FROM imoveis where id = '" + id_imovel + "' ");
                                while (rs.next()) {
                                    cpfCorretor = rs.getString(3);
                                }

                                out.print("<option value='0'>Selecionar Comprador</option>");

                                st = new Conexao().conectar().createStatement();
                                rs = st.executeQuery("SELECT * FROM compradores where corretor = '" + cpfCorretor + "' order by id desc limit 30");

                                while (rs.next()) {

                                    out.print("<option value='" + rs.getString(1) + "'>" + rs.getString(2) + "</option>");

                                }

                            %>

                        </select>
                    </div>


                    <div class="form-group">
                        <label >CPF/CNPJ Comprador</label>
                        <div class="input-group">
                            <input type="text" class="form-control small" placeholder="CPF/CNPJ" name="doc" id="doc" aria-label="Search" aria-describedby="basic-addon2">
                            <div class="input-group-append">
                                <button id="btn-buscar" name="btn-buscar" class="btn btn-primary" type="button">
                                    <i class="fas fa-search fa-sm"></i>
                                </button>
                            </div>
                        </div>

                    </div>



                    <div class="form-group">
                        <label >Nome Comprador</label>
                        <input readonly type="text" name="nomeVendedor" id="nomeVendedor" class="form-control" placeholder="Nome Inquilino">
                    </div>




                    <div class="form-group" id="divcpf">
                        <label >Data Pgto</label>
                        <input type="date" class="form-control" id="datapgto" name="datapgto">
                    </div>






                    <div align="center" id="mensagem_excluir" class="">

                    </div>

                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" id="btn-cancelar-excluir">Cancelar</button>

                    <%id = request.getParameter("id");%>
                    <input type="hidden" id="id"  name="id" value="<%=id%>" required>


                    <button type="button" id="btn-salvar" name="btn-salvar" class="btn btn-primary">Salvar</button>
                </div>
            </form>

        </div>
    </div>
</div>





<%    if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("modal")) {

        out.print("<script>$('#modal').modal('show');</script>");
    }

%>                    




<!--AJAX PARA EDIÇÃO DOS DADOS -->
<script type="text/javascript">
    $(document).ready(function () {
        var pag = "<%=pag%>";
        $('#btn-salvar').click(function (event) {
            event.preventDefault();

            $.ajax({
                url: pag + "/vender.jsp",
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




<!--AJAX PARA LISTAR OS DADOS DO VENDEDOR -->
<script type="text/javascript">
    $(document).ready(function () {

        //$('#btn-buscar').click();
        var pag = "<%=pag%>";

        $.ajax({
            url: pag + "/buscar-vendedor.jsp",
            method: "post",
            data: $('#frm').serialize(),
            dataType: "html",
            success: function (result) {
                console.log(result);
                document.getElementById('nomeVendedor').value = result;
            }
        })


    })
</script>



<!--AJAX PARA BUSCAR DADOS PELO BOTÃO -->
<script type="text/javascript">

    $('#btn-buscar').click(function (event) {
        var pag = "<%=pag%>";

        event.preventDefault();
        $.ajax({
            url: pag + "/buscar-vendedor.jsp",
            method: "post",
            data: $('form').serialize(),
            dataType: "html",
            success: function (result) {
                console.log(result);
                var resultado = result.split(",");

                if (result == 0) {
                    document.getElementById('nomeVendedor').value = "";
                    document.getElementById('doc').value = "";
                    document.getElementById('btn-salvar').disabled = true;
                } else {
                    document.getElementById('nomeVendedor').value = resultado[0];
                    document.getElementById('doc').value = resultado[1];
                    document.getElementById('btn-salvar').disabled = false;
                }

            }
        })
    })


</script>




<!-- Script para buscar pelo select -->
<script type="text/javascript">
    $(document).ready(function () {

        document.getElementById('doc').value = "";
        document.getElementById('btn-salvar').disabled = true;

        $('#vendedor').change(function () {


            if ($(this).val() === '0') {
                document.getElementById('doc').value = "";
                document.getElementById('nomeVendedor').value = "";
                document.getElementById('btn-salvar').disabled = true;
            } else {
                document.getElementById('btn-salvar').disabled = false;
            }


            $('#btn-buscar').click();


        });

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