<%@page import="java.time.*"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%> 

<% String pag = "pagar";%>

<%@page import="util.Upload" %>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>





<%
    Statement st = null;
    Statement st2 = null;
    Statement st3 = null;

    ResultSet rs = null;
    ResultSet rs2 = null;
    ResultSet rs3 = null;

    String id = "";
    Date dataHoje = new Date(System.currentTimeMillis());
    String classe = "";

    String foto = "";

%>



<div class="row mt-4 mb-4">
    <a type="button" class="btn-primary btn-sm ml-3 d-none d-md-block" href="index.jsp?pag=<%=pag%>&funcao=novo">Novo Pagamento</a>
    <a type="button" class="btn-primary btn-sm ml-3 d-block d-sm-none" href="index.jsp?pag=<%=pag%>&funcao=novo">+</a>

</div>

<!-- DataTales Example -->
<div class="card shadow mb-4">

    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                    <tr>
                        <th>Título</th>
                        <th>Descrição</th>
                        <th>Valor</th>
                        <th>Tesoureiro</th>
                        <th>Data PGTO</th>
                        <th>Foto ou PDF</th>
                        <th>Dar Baixa</th>

                    </tr>
                </thead>

                <tbody>

                    <%                        try {
                            String titulo = "";
                            String valor = "";
                            String descricao = "";
                            String tesoureiro = "";

                            String dataPgto = "";
                            String nomeTesoureiro = "";

                            st = new Conexao().conectar().createStatement();
                            st2 = new Conexao().conectar().createStatement();
                            st3 = new Conexao().conectar().createStatement();
                            rs = st.executeQuery("SELECT * FROM contas_pagar where pago = 'Não' order by data asc ");
                            while (rs.next()) {
                                titulo = rs.getString(3);
                                valor = rs.getString(2);
                                descricao = rs.getString(4);
                                dataPgto = rs.getString(7);
                                tesoureiro = rs.getString(6);
                                id = rs.getString(1);
                                foto = rs.getString(8);

                                double vlr = 0;
                                vlr = Double.parseDouble(valor);
                                valor = (NumberFormat.getCurrencyInstance().format(vlr));

                                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                                java.util.Date minhaData = format.parse(dataPgto);

                                String[] dataSeparada = dataPgto.split("-");
                                dataPgto = dataSeparada[2] + "/" + dataSeparada[1] + "/" + dataSeparada[0];

                                rs2 = st2.executeQuery("SELECT * FROM tesoureiros where cpf = '" + tesoureiro + "' ");
                                while (rs2.next()) {

                                    nomeTesoureiro = rs2.getString(2);
                                }

                                if (minhaData.before(dataHoje)) {
                                    classe = "text-danger";
                                } else {
                                    classe = "text-success";
                                }
                    %>

                    <tr>
                        <td><%=titulo%></td>
                        <td><%=descricao%></td>
                        <td><%=valor%></td>
                        <td><%=nomeTesoureiro%></td>

                        <td><%=dataPgto%></td>

                        <td>
                            <%
                            if(foto != null && !foto.equals("")){ %>
                               
                            <a href="../img/contas/<%=foto%>" target="_blank" class="mr-2">Ver Arquivo</a>
                            
                            <%  }else{ %>
                            Inserir
                             <%  } %>
                            <a href="index.jsp?pag=<%=pag%>&funcao=foto&id=<%=id%>" class='text-primary mr-1' title='Inserir Foto ou PDF'><i class='far fa-image'></i></a>

                        </td>

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




<!-- Modal -->
<div class="modal fade" id="modalDados" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">

                <h5 class="modal-title" id="exampleModalLabel">Inserir Pagamento</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="form" method="POST">
                <div class="modal-body">

                    <div class="form-group">
                        <label >Titulo</label>
                        <input type="text" class="form-control" id="titulo" name="titulo" placeholder="Título">
                    </div>


                    <div class="form-group">
                        <label >Descrição</label>
                        <input type="text" class="form-control" id="descricao" name="descricao" placeholder="Descrição">
                    </div>

                    <div class="form-group">
                        <label >Valor</label>
                        <input type="text" class="form-control" id="valor" name="valor" placeholder="Valor">
                    </div>



                    <small>
                        <div id="mensagem">

                        </div>
                    </small> 

                </div>



                <div class="modal-footer">




                    <button type="button" id="btn-fechar" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                    <button type="submit" name="btn-salvar" id="btn-salvar" class="btn btn-primary">Salvar</button>
                </div>
            </form>
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
                <p>Este valor de <%=valor2%> Reais já foi pago por você?</p>

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





<div class="modal" id="modal-imagens" data-backdrop="static" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Inserir Foto</h5>
                <button id="btn-fechar-imagens" type="button" class="close"  data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <form id="form-img" method="POST" enctype="multipart/form-data" >
                    <div class="row">
                        <div class="col-md-6">
                            <div class="col-md-12 form-group">
                                <label>Foto ou PDF</label>
                                <input value="<%=foto%>" type="file" class="form-control-file" id="imagem" name="imagem[]" onchange="carregarImg();">

                            </div>

                        </div>

                        <div class="col-md-6" align="right">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal" id="btn-cancelar-imagem">Cancelar</button>
                            <%id = request.getParameter("id");%>
                            <input type="hidden" id="id"  name="id" value="<%=id%>" required>

                            <button type="submit" id="btn-principal" name="btn-imagem" class="btn btn-info">Salvar</button>

                        </div>

                    </div>

                    <div class="col-md-12 mb-2">
                        <img src="../img/contas/<%=foto%>" alt="Carregue sua Imagem ou PDF" id="target" width="100%">
                    </div>


                    <div align="center" id="mensagem_img" class="">

                    </div>
                </form>

            </div>

        </div>
    </div>
</div>           



<%    if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("novo")) {
        out.print("<script>$('#modalDados').modal('show');</script>");
    }

%>




<%    if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("baixa")) {

        out.print("<script>$('#modal').modal('show');</script>");
    }

%>                    


<%    if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("foto")) {

        out.print("<script>$('#modal-imagens').modal('show');</script>");
    }

%>  




<!--AJAX PARA INSERÇÃO DOS DADOS -->
<script type="text/javascript">
    $(document).ready(function () {
        var pag = "<%=pag%>";

        $('#btn-salvar').click(function (event) {
            event.preventDefault();
            console.log(pag);
            $.ajax({
                url: pag + "/inserir.jsp",
                method: "post",
                data: $('form').serialize(),
                dataType: "text",
                success: function (mensagem) {

                    $('#mensagem').removeClass()

                    if (mensagem.trim() == "Salvo com Sucesso!!") {
                        $('#mensagem').addClass('text-success')
                        $('#nome').val('')
                        //$('#btn-buscar').click();
                        $('#btn-fechar').click();
                        window.location = "index.jsp?pag=" + pag;
                    } else {

                        $('#mensagem').addClass('text-danger')
                    }

                    $('#mensagem').text(mensagem)

                },

            })
        })
    })
</script>


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





<!--AJAX PARA EXECUTAR A EDIÇÃO DA IMAGEM DA FOTO -->
<script type="text/javascript">


    $("#form-img").submit(function () {

        var pag = "<%=pag%>";
        event.preventDefault();
        var formData = new FormData(this);

        $.ajax({
            url: pag + "/imagem.jsp",
            type: 'POST',
            data: formData,

            success: function (mensagem) {

                $('#mensagem_img').removeClass()

                if (mensagem.trim() == "Salvo com Sucesso!!") {
                    $('#mensagem_img').addClass('text-success');
                    //$('#nome').val('');
                    //$('#cpf').val('');
                    $('#btn-cancelar-imagem').click();
                    window.location = "index.jsp?pag=" + pag;

                } else {

                    $('#mensagem_img').addClass('text-danger')

                }

                $('#mensagem_img').text(mensagem)

            },

            cache: false,
            contentType: false,
            processData: false,
            xhr: function () {  // Custom XMLHttpRequest
                var myXhr = $.ajaxSettings.xhr();
                if (myXhr.upload) { // Avalia se tem suporte a propriedade upload
                    myXhr.upload.addEventListener('progress', function () {
                        /* faz alguma coisa durante o progresso do upload */
                    }, false);
                }
                return myXhr;
            }
        });
    });



</script>



<script type="text/javascript">
 function carregarImg() {

        var target = document.getElementById('target');
        var file = document.querySelector("input[id=imagem]").files[0];
        var reader = new FileReader();

        reader.onloadend = function () {
            target.src = reader.result;
        };

        if (file) {
            reader.readAsDataURL(file);


        } else {
            target.src = "";
        }
    }

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