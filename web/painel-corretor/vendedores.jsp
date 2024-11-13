<% String pag = "vendedores";%>

<%@page import="util.Upload" %>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>



<%
    Statement st = null;
    ResultSet rs = null;
    
    String cpfUsuario = (String) session.getAttribute("cpfUsuario");
%>

<div class="row mt-4 mb-4">
    <a type="button" class="btn-primary btn-sm ml-3 d-none d-md-block" href="index.jsp?pag=<%=pag%>&funcao=novo">Novo Cliente</a>
    <a type="button" class="btn-primary btn-sm ml-3 d-block d-sm-none" href="index.jsp?pag=<%=pag%>&funcao=novo">+</a>

</div>




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
                        <th>Ações</th>
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

                            String id = "";

                            st = new Conexao().conectar().createStatement();
                            rs = st.executeQuery("SELECT * FROM vendedores where corretor = '"+cpfUsuario+"' order by nome asc ");
                            while (rs.next()) {
                                nome = rs.getString(2);
                                cpf = rs.getString(4);
                                telefone = rs.getString(5);
                                tipo = rs.getString(3);
                                endereco = rs.getString(6);

                                id = rs.getString(1);
                    %>

                    <tr>
                        <td><%=nome%></td>
                        <td><%=tipo%></td>
                        <td><%=cpf%></td>
                        <td><%=telefone%></td>

                        <td><%=endereco%></td>

                        <td>
                            <a href="index.jsp?pag=<%=pag%>&funcao=editar&id=<%=id%>" class='text-primary mr-1' title='Editar Dados'><i class='far fa-edit'></i></a>
                            <a href="index.jsp?pag=<%=pag%>&funcao=excluir&id=<%=id%>" class='text-danger mr-1' title='Excluir Registro'><i class='far fa-trash-alt'></i></a>
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
                    String nome = "";
                    String cpf = "";
                    String telefone = "";
                    String tipo = "";
                    String endereco = "";

                    String id = "";
                    String titulo = "";

                    if (request.getParameter(
                            "id") != null) {
                        titulo = "Editar Registro";
                        id = request.getParameter("id");
                        try {
                            st = new Conexao().conectar().createStatement();
                            rs = st.executeQuery("SELECT * FROM vendedores where id = '" + id + "' ");
                            while (rs.next()) {
                                nome = rs.getString(2);
                                cpf = rs.getString(4);
                                telefone = rs.getString(5);
                                tipo = rs.getString(3);
                                endereco = rs.getString(6);

                            }
                        } catch (Exception e) {
                            out.print(e);
                        }
                    } else {
                        titulo = "Inserir Registro";
                    }

                %>
                <h5 class="modal-title" id="exampleModalLabel"><%=titulo%></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="form" method="POST">
                <div class="modal-body">

                    <div class="form-group">
                        <label >Nome</label>
                        <input value="<%=nome%>" type="text" class="form-control" id="nome" name="nome" placeholder="Nome">
                    </div>

                    <div class="form-group">
                        <label >Tipo</label>
                        <select class="form-control" id="tipo" name="tipo">

                            <%
                                if (request.getParameter(
                                        "id") != null) {
                                    String tipobd = "";
                                    if (tipo.equals("Fisica")) {
                                        tipobd = "Pessoa Física";
                                    } else {
                                        tipobd = "Pessoa Jurídica";
                                    }%>

                            <option value="<%=tipo%>"><%=tipobd%></option>

                            <% } %>

                            <% if (!tipo.equals("Fisica")) { %>
                            <option value="Fisica">Pessoa Física</option>
                            <% } %>

                            <% if (!tipo.equals("Juridica")) { %>
                            <option value="Juridica">Pessoa Jurídica</option>
                            <% }%>



                        </select>
                    </div>

                    <div class="form-group" id="divcpf">
                        <label >CPF</label>
                        <input value="<%=cpf%>" type="text" class="form-control" id="cpf" name="cpf" placeholder="CPF">
                    </div>

                    <div class="form-group" id="divcnpj">
                        <label >CNPJ</label>
                        <input value="<%=cpf%>" type="text" class="form-control" id="cnpj" name="cnpj" placeholder="CNPJ">
                    </div>

                    <div class="form-group">
                        <label >Telefone</label>
                        <input value="<%=telefone%>" type="text" class="form-control" id="telefone" name="telefone" placeholder="Telefone">
                    </div>

                    <div class="form-group">
                        <label >Endereço</label>
                        <input value="<%=endereco%>" type="text" class="form-control" id="endereco" name="endereco" placeholder="Endereço">
                    </div>

                    <small>
                        <div id="mensagem">

                        </div>
                    </small> 

                </div>



                <div class="modal-footer">



                    <input value="<%=id%>" type="hidden" name="txtid" id="txtid">
                    <input value="<%=cpf%>" type="hidden" name="antigo" id="antigo">

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



<!-- Script para mostrar cpf ou cnpj -->
<script type="text/javascript">
    $(document).ready(function () {
        var tipo = "<%=tipo%>";
        if (tipo === "Juridica") {
            $('#divcpf').hide();
            $('#divcnpj').show();
        } else {
            $('#divcpf').show();
            $('#divcnpj').hide();
        }

        $('#tipo').change(function () {
            if ($(this).val() == 'Fisica') {
                $('#divcpf').show();
                $('#divcnpj').hide();
            } else {
                $('#divcpf').hide();
                $('#divcnpj').show();
            }


        });

    })
</script>



<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.11/jquery.mask.min.js"></script>

<script src="../../js/mascara.js"></script>