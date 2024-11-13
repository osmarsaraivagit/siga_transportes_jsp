<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
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

    String id = "";
    String id_registro = "";
%>

<div class="row mt-4 mb-4">
    <a type="button" class="btn-primary btn-sm ml-3 d-none d-md-block" href="index.jsp?pag=<%=pag%>&funcao=novo">Nova Tarefa</a>
    <a type="button" class="btn-primary btn-sm ml-3 d-block d-sm-none" href="index.jsp?pag=<%=pag%>&funcao=novo">+</a>

</div>




<!-- DataTales Example -->
<div class="card shadow mb-4">

    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                    <tr>
                        <th>Titulo</th>
                        <th>Data</th>
                        <th>Hora</th>
                        <th>Imóvel</th>
                        <th>Ações</th>
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
                            String status = "";
                            String classe = "";

                            st = new Conexao().conectar().createStatement();
                            rs = st.executeQuery("SELECT * FROM tarefas where corretor = '" + cpfUsuario + "' order by id desc ");
                            while (rs.next()) {
                                titulo = rs.getString(2);
                                descricao = rs.getString(3);
                                data = rs.getString(4);
                                hora = rs.getString(5);
                                imovel = rs.getString(6);
                                status = rs.getString(8);

                                id = rs.getString(1);

                                
                                String[] dataSeparada = data.split("-");
                                data = dataSeparada[2] + "/" + dataSeparada[1] + "/" + dataSeparada[0];
                                
                                
                                if (status.equals("")) {
                                    classe = "text-danger";
                                } else {
                                    classe = "text-success";
                                }

                    %>

                    <tr>
                        <td><i class="<%=classe%> mr-1 fas fa-square "></i><%=titulo%></td>
                        <td><%=data%></td>
                        <td><%=hora%></td>
                        <td><%=imovel%></td>



                        <td>
                            <a href="index.jsp?pag=<%=pag%>&funcao=editar&id=<%=id%>" class='text-primary mr-1' title='Editar Dados'><i class='far fa-edit'></i></a>
                            <a href="index.jsp?pag=<%=pag%>&funcao=excluir&id=<%=id%>" class='text-danger mr-1' title='Excluir Registro'><i class='far fa-trash-alt'></i></a>
                            <a href="index.jsp?pag=<%=pag%>&funcao=concluir&id=<%=id%>" class='text-success mr-1' title='Concluir Tarefa'><i class='far fa-check-square'></i></a>
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
                <%
                    String titulo = "";
                    String descricao = "";
                    String data = "";
                    String hora = "";
                    String imovel = "";

                    String titulo_modal = "";

                    if (request.getParameter(
                            "id") != null) {
                        titulo_modal = "Editar Registro";
                        id_registro = request.getParameter("id");
                        try {
                            st = new Conexao().conectar().createStatement();
                            rs = st.executeQuery("SELECT * FROM tarefas where id = '" + id_registro + "' ");
                            while (rs.next()) {
                                titulo = rs.getString(2);
                                descricao = rs.getString(3);
                                data = rs.getString(4);
                                hora = rs.getString(5);
                                imovel = rs.getString(6);

                            }
                        } catch (Exception e) {
                            out.print(e);
                        }
                    } else {
                        titulo_modal = "Inserir Registro";
                    }

                %>
                <h5 class="modal-title" id="exampleModalLabel"><%=titulo_modal%></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="form" method="POST">
                <div class="modal-body">

                    <div class="form-group">
                        <label >Titulo</label>
                        <input value="<%=titulo%>" type="text" class="form-control" id="titulo" name="titulo" placeholder="Titulo">
                    </div>

                    <div class="form-group">
                        <label >Descrição</label>
                        <input value="<%=descricao%>" type="text" class="form-control" id="descricao" name="descricao" placeholder="Descrição da Tarefa">
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group" id="divcpf">
                                <label >Data</label>
                                <input value="<%=data%>" type="date" class="form-control" id="data" name="data">
                            </div>
                        </div>
                        <div class="col-md-6">

                            <div class="form-group" id="divcnpj">
                                <label >Hora</label>
                                <input value="<%=hora%>" type="time" class="form-control" id="hora" name="hora">
                            </div>
                        </div>
                    </div>



                    <div class="form-group">
                        <label >Código Imóvel (Se For Visita)</label>
                        <input value="<%=imovel%>" type="text" class="form-control" id="imovel" name="imovel" placeholder="Id do Imóvel">
                    </div>



                    <small>
                        <div id="mensagem">

                        </div>
                    </small> 

                </div>



                <div class="modal-footer">



                    <input value="<%=id_registro%>" type="hidden" name="txtid" id="txtid">
                    <input value="<%=hora%>" type="hidden" name="antigo" id="antigo">
                    <input value="<%=data%>" type="hidden" name="antigo2" id="antigo2">

                    <button type="button" id="btn-fechar" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                    <button type="submit" name="btn-salvar" id="btn-salvar" class="btn btn-primary">Salvar</button>
                </div>
            </form>
        </div>
    </div>
</div>





<div class="modal" id="modal-deletar" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Excluir Registro</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <p>Deseja realmente Excluir este Registro?</p>

                <div align="center" id="mensagem_excluir" class="">

                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal" id="btn-cancelar-excluir">Cancelar</button>
                <form method="post">
                    <%id = request.getParameter("id");%>
                    <input type="hidden" id="id"  name="id" value="<%=id%>" required>

                    <button type="button" id="btn-deletar" name="btn-deletar" class="btn btn-danger">Excluir</button>
                </form>
            </div>
        </div>
    </div>
</div>





<div class="modal" id="modal-concluir" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Concluir Tarefa</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <p>Deseja realmente Concluir esta tarefa?</p>

                <div align="center" id="mensagem_concluir" class="">

                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal" id="btn-cancelar-concluir">Cancelar</button>
                <form method="post">
                    <%id = request.getParameter("id");%>
                    <input type="hidden" id="id"  name="id" value="<%=id%>" required>

                    <button type="button" id="btn-concluir" name="btn-concluir" class="btn btn-danger">Concluir</button>
                </form>
            </div>
        </div>
    </div>
</div>




<%    if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("novo")) {
        out.print("<script>$('#modalDados').modal('show');</script>");
    }

%>

<%    if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("editar")) {
        out.print("<script>$('#modalDados').modal('show');</script>");
    }

%>


<%    if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("excluir")) {

        out.print("<script>$('#modal-deletar').modal('show');</script>");
    }

%>                    


<%    if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("concluir")) {

        out.print("<script>$('#modal-concluir').modal('show');</script>");
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
                url: pag + "/excluir.jsp",
                method: "post",
                data: $('form').serialize(),
                dataType: "text",
                success: function (mensagem) {

                    if (mensagem.trim() === 'Excluído com Sucesso!!') {


                        $('#btn-cancelar-excluir').click();
                        window.location = "index.jsp?pag=" + pag;
                    }

                    $('#mensagem_excluir').text(mensagem)



                },

            })
        })
    })
</script>




<!--AJAX PARA CONCLUIR TAREFA -->
<script type="text/javascript">
    $(document).ready(function () {
        var pag = "<%=pag%>";
        $('#btn-concluir').click(function (event) {
            event.preventDefault();

            $.ajax({
                url: pag + "/concluir.jsp",
                method: "post",
                data: $('form').serialize(),
                dataType: "text",
                success: function (mensagem) {

                    if (mensagem.trim() === 'Excluído com Sucesso!!') {


                        $('#btn-cancelar-concluir').click();
                        window.location = "index.jsp?pag=" + pag;
                    }

                    $('#mensagem_concluir').text(mensagem)



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