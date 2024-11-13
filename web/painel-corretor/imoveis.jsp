<% String pag = "imoveis";%>

<%@page import="util.Upload" %>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>
<%@page import="java.text.NumberFormat"%> 


<% 
    String cpfUsuario = (String) session.getAttribute("cpfUsuario");
    String idImov = request.getParameter("id");
%>

<%
    Statement st = null;
    ResultSet rs = null;

    Statement st2 = null;
    ResultSet rs2 = null;

    Statement st3 = null;
    ResultSet rs3 = null;
%>

<div class="row mt-4 mb-4">
    <a type="button" class="btn-primary btn-sm ml-3 d-none d-md-block" href="index.jsp?pag=<%=pag%>&funcao=novo">Novo Imóvel</a>
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
                        <th>Vendedor</th>
                        <th>Valor</th>

                        <th>Bairro</th>
                        <th>Status</th>
                        <th>Foto</th>
                        <th>Ações</th>
                    </tr>
                </thead>

                <tbody>

                    <%
                        try {
                            String vendedor = "";
                            String valor = "";
                            String bairro = "";
                            String status = "";
                            String titulo = "";

                            String nomeBairro = "";
                            String nomeVendedor = "";

                            String imagem = "";
                            String id = "";

                            st = new Conexao().conectar().createStatement();
                            st2 = new Conexao().conectar().createStatement();
                            st3 = new Conexao().conectar().createStatement();
                            rs = st.executeQuery("SELECT * FROM imoveis where corretor = '"+cpfUsuario+"' order by id desc ");
                            while (rs.next()) {
                                vendedor = rs.getString(2);
                                valor = rs.getString(9);
                                bairro = rs.getString(8);
                                status = rs.getString(22);
                                titulo = rs.getString(4);

                                imagem = rs.getString(18);
                                id = rs.getString(1);

                                rs2 = st2.executeQuery("SELECT * FROM bairros where id = '" + bairro + "' ");
                                while (rs2.next()) {
                                    nomeBairro = rs2.getString(2);
                                }

                                rs3 = st3.executeQuery("SELECT * FROM vendedores where doc = '" + vendedor + "' ");
                                while (rs3.next()) {
                                    nomeVendedor = rs3.getString(2);
                                }

                                double vlr = 0;
                                vlr = Double.parseDouble(valor);
                                valor = (NumberFormat.getCurrencyInstance().format(vlr));


                    %>

                    <tr>
                        <td><%=titulo%></td>
                        <td><%=nomeVendedor%></td>
                        <td><%=valor%></td>
                        <td><%=nomeBairro%></td>
                        <td><%=status%></td>

                        <td><img src="../img/imoveis/<%=imagem%>" width="50px"></td>
                        <td>
                            <a href="index.jsp?pag=<%=pag%>&funcao=editar&id=<%=id%>" class='text-primary mr-1' title='Editar Dados'><i class='far fa-edit'></i></a>
                            <a href="index.jsp?pag=<%=pag%>&funcao=excluir&id=<%=id%>" class='text-danger mr-1' title='Excluir Registro'><i class='far fa-trash-alt'></i></a>
                            <a href="index.jsp?pag=<%=pag%>&funcao=imagens&id=<%=id%>" class='text-info mr-1' title='Inserir Imagens'><i class='far fa-file-image'></i></a>
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
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <%
                    String vendedor = "";
                    String corretor = "";
                    String titulo = "";
                    String descricao = "";
                    String tipo = "";
                    String cidade = "";
                    String bairro = "";
                    String valor = "";
                    String ano = "";
                    String visitas = "";
                    String area = "";
                    String quartos = "";
                    String banheiros = "";
                    String suites = "";
                    String garagens = "";
                    String piscinas = "";
                    String imgPrincipal = "sem-img.jpg";
                    String imgPlanta = "sem-img.jpg";
                    String imgBanner = "sem-img.jpg";
                    String endereco = "";
                    String status = "";
                    String condicao = "";

                    String id = "";
                    String tituloModal = "";

                    if (request.getParameter(
                            "id") != null) {
                        tituloModal = "Editar Registro";
                        id = request.getParameter("id");

                        try {
                            st = new Conexao().conectar().createStatement();
                            rs = st.executeQuery("SELECT * FROM imoveis where id = '" + id + "' ");
                            while (rs.next()) {
                                id = rs.getString(1);
                                vendedor = rs.getString(2);
                                corretor = rs.getString(3);
                                titulo = rs.getString(4);
                                descricao = rs.getString(5);
                                tipo = rs.getString(6);
                                cidade = rs.getString(7);
                                bairro = rs.getString(8);
                                valor = rs.getString(9);
                                ano = rs.getString(10);
                                visitas = rs.getString(11);
                                area = rs.getString(12);
                                quartos = rs.getString(13);
                                banheiros = rs.getString(14);
                                suites = rs.getString(15);
                                garagens = rs.getString(16);
                                piscinas = rs.getString(17);
                                imgPrincipal = rs.getString(18);
                                imgPlanta = rs.getString(19);
                                imgBanner = rs.getString(20);
                                endereco = rs.getString(21);
                                status = rs.getString(22);
                                condicao = rs.getString(23);

                            }
                        } catch (Exception e) {
                            out.print(e);
                        }
                    } else {
                        tituloModal = "Inserir Registro";
                    }

                %>
                <h5 class="modal-title" id="exampleModalLabel"><%=tituloModal%></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="form" method="POST" enctype="multipart/form-data" >
                <div class="modal-body">


                    <div class="row">
                        <div class="col-md-4 col-sm-12">
                            <div class="form-group">
                                <label >Vendedor</label>
                                <select class="form-control" name="vendedor" id="vendedor">

                                    <%
                                        String nome = "";
                                        //recuperar o nome do campo para mostrar de inicio no select
                                        if (!id.equals("")) {
                                            rs = st.executeQuery("SELECT * FROM vendedores where doc = '" + vendedor + "' ");
                                            while (rs.next()) {
                                                nome = rs.getString(2);

                                            }
                                            out.print("<option value='" + vendedor + "'>" + nome + "</option>");

                                        } else {
                                            out.print("<option value='0'>Selecionar Vendedor</option>");
                                        }

                                        st = new Conexao().conectar().createStatement();
                                        rs = st.executeQuery("SELECT * FROM vendedores where corretor = '"+cpfUsuario+"' order by id desc limit 30");

                                        while (rs.next()) {
                                            if (!nome.equals(rs.getString(2))) {
                                                out.print("<option value='" + rs.getString(1) + "'>" + rs.getString(2) + "</option>");
                                            }

                                        }

                                    %>

                                </select>
                            </div>
                        </div>
                        <div class="col-md-4 col-sm-12">
                            <div class="form-group">
                                <label >CPF/CNPJ Vendedor</label>
                                <div class="input-group">
                                    <input value="<%=vendedor%>" type="text" class="form-control small" placeholder="CPF/CNPJ" name="doc" id="doc" aria-label="Search" aria-describedby="basic-addon2">
                                    <div class="input-group-append">
                                        <button id="btn-buscar" name="btn-buscar" class="btn btn-primary" type="button">
                                            <i class="fas fa-search fa-sm"></i>
                                        </button>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <div class="col-md-4 col-sm-12">
                            <div class="form-group">
                                <label >Nome Vendedor</label>
                                <input value="<%=nome%>" readonly type="text" name="nomeVendedor" id="nomeVendedor" class="form-control" placeholder="Nome Vendedor">
                            </div>
                        </div>



                    </div>


                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label >Tipo</label>
                                <select class="form-control" name="tipo" id="tipo">

                                    <%  String nome2 = "";
                                        //recuperar o nome do campo para mostrar de inicio no select
                                        if (!id.equals("")) {

                                            rs = st.executeQuery("SELECT * FROM tipos where id = '" + tipo + "' ");
                                            while (rs.next()) {
                                                nome2 = rs.getString(2);
                                            }
                                            out.print("<option value='" + tipo + "'>" + nome2 + "</option>");

                                        }

                                        st = new Conexao().conectar().createStatement();
                                        rs = st.executeQuery("SELECT * FROM tipos order by nome asc");

                                        while (rs.next()) {
                                            if (!nome2.equals(rs.getString(2))) {
                                                out.print("<option value='" + rs.getString(1) + "'>" + rs.getString(2) + "</option>");
                                            }

                                        }

                                    %>

                                </select>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="form-group">
                                <label >Cidade</label>
                                <select class="form-control" name="cidade" id="cidade">

                                    <%                                        String nome3 = "";
                                        //recuperar o nome do campo para mostrar de inicio no select
                                        if (!id.equals("")) {

                                            rs = st.executeQuery("SELECT * FROM cidades where id = '" + cidade + "' ");
                                            while (rs.next()) {
                                                nome3 = rs.getString(2);
                                            }
                                            out.print("<option value='" + cidade + "'>" + nome3 + "</option>");

                                        }

                                        st = new Conexao().conectar().createStatement();
                                        rs = st.executeQuery("SELECT * FROM cidades order by nome asc");

                                        while (rs.next()) {
                                            if (!nome3.equals(rs.getString(2))) {
                                                out.print("<option value='" + rs.getString(1) + "'>" + rs.getString(2) + "</option>");
                                            }

                                        }

                                    %>

                                </select>
                            </div>
                        </div>

                        <div class="col-md-4" id="listar-bairros">

                        </div>
                        <input value="<%=bairro%>" type="hidden" name="txtbairro" id="txtbairro">
                        <input value="teste" type="hidden" name="txtcidade" id="txtcidade">
                        <button id="btn-buscar-bairro" name="btn-buscar-bairro" class="border-0" type="hidden"></button> 

                    </div>   


                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label >Titulo</label>
                                <input value="<%=titulo%>" type="text" name="titulo" id="titulo" class="form-control" placeholder="Título">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label >Valor</label>
                                <input value="<%=valor%>" type="text" name="valor" id="valor" class="form-control" placeholder="Valor">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label >Ano</label>
                                <input value="<%=ano%>" type="number" name="ano" id="ano" class="form-control" placeholder="Ano">
                            </div>
                        </div>
                    </div>


                    <div class="row">
                        <div class="col-md-2">
                            <div class="form-group">
                                <label >Área</label>
                                <input value="<%=area%>" type="number" name="area" id="area" class="form-control" placeholder="Área">
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label >Quartos</label>
                                <input value="<%=quartos%>" type="number" name="quartos" id="quartos" class="form-control" placeholder="Quartos">
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label >Banheiros</label>
                                <input value="<%=banheiros%>" type="number" name="banheiros" id="banheiros" class="form-control" placeholder="Banheiros">
                            </div>
                        </div>

                        <div class="col-md-2">
                            <div class="form-group">
                                <label >Suítes</label>
                                <input value="<%=suites%>" type="number" name="suites" id="suites" class="form-control" placeholder="Suítes">
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label >Garagens</label>
                                <input value="<%=garagens%>" type="number" name="garagens" id="garagens" class="form-control" placeholder="Garagens">
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label >Piscinas</label>
                                <input value="<%=piscinas%>" type="number" name="piscinas" id="piscinas" class="form-control" placeholder="Piscinas">
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label >Descrição</label>
                        <textarea maxlength="1000" type="text" name="descricao" id="descricao" class="form-control"><%=descricao%></textarea>
                    </div>  

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label >Endereço</label>
                                <input value="<%=endereco%>" type="text" name="endereco" id="endereco" class="form-control" placeholder="Endereço">
                            </div>
                        </div>

                        <div class="col-md-3">
                            <div class="form-group">
                                <label >Status</label>
                                <select class="form-control" id="status" name="status">

                                    <%
                                        if (request.getParameter(
                                                "id") != null) {%>

                                    <option value="<%=status%>"><%=status%></option>

                                    <% } %>

                                    <% if (!status.equals("Para Venda")) { %>
                                    <option value="Para Venda">Para Venda</option>
                                    <% } %>

                                    <% if (!status.equals("Para Aluguel")) { %>
                                    <option value="Para Aluguel">Para Aluguel</option>
                                    <% } %>

                                    <%
                                        if (request.getParameter(
                                                "id") != null) {%>

                                    <% if (!status.equals("Vendido")) { %>
                                    <option value="Vendido">Vendido</option>
                                    <% }%>

                                    <% if (!status.equals("Alugado")) { %>
                                    <option value="Alugado">Alugado</option>
                                    <% }%>

                                    <% } %>

                                    <% if (!status.equals("Inativo")) { %>
                                    <option value="Inativo">Inativo</option>
                                    <% }%>



                                </select>
                            </div>
                        </div>


                        <div class="col-md-3">
                            <div class="form-group">
                                <label >Condição</label>
                                <select class="form-control" id="condicao" name="condicao">

                                    <%
                                        if (request.getParameter(
                                                "id") != null) {%>

                                    <option value="<%=condicao%>"><%=condicao%></option>

                                    <% } %>

                                    <% if (!condicao.equals("Usado")) { %>
                                    <option value="Usado">Usado</option>
                                    <% } %>

                                    <% if (!condicao.equals("Novo")) { %>
                                    <option value="Novo">Novo</option>
                                    <% } %>

                                    <% if (!condicao.equals("Planta")) { %>
                                    <option value="Planta">Planta</option>
                                    <% }%>




                                </select>
                            </div>
                        </div>


                    </div>



                    <small>
                        <div id="mensagem">

                        </div>
                    </small> 


                </div>
                <div class="modal-footer">



                    <input value="<%=id%>" type="hidden" name="txtid" id="txtid">


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





<div class="modal" id="modal-imagens" data-backdrop="static" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Inserir Imagens</h5>
                <button id="btn-fechar-imagens" type="button" class="close"  data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <a title="Inserir Foto Principal " href="" data-target="#modalPrincipal" data-toggle="modal" class="text-info mr-2"><i class="fas fa-image mr-1"></i>Principal</a>
                <a title="Inserir Foto Banner " href="" data-target="#modalBanner" data-toggle="modal" class="text-success mr-2"><i class="fas fa-image mr-1"></i>Banner</a>
                <a title="Inserir Foto Planta " href="" data-target="#modalPlanta" data-toggle="modal" class="text-primary mr-2"><i class="fas fa-image mr-1"></i>Planta</a>
                <a title="Inserir Fotos " href="" data-target="#modalFotos" data-toggle="modal" class="text-secondary mr-2"><i class="fas fa-image mr-1"></i>Demais Fotos</a>


            </div>

        </div>
    </div>
</div>                    


<div class="modal" id="modalPrincipal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Foto Principal</h5>
                <button type="button" class="close"  data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="form-principal" method="POST" enctype="multipart/form-data" >
                    <div class="row">
                        <div class="col-md-6">
                            <div class="col-md-12 form-group">
                                <label>Foto Principal</label>
                                <input value="<%=imgPrincipal%>" type="file" class="form-control-file" id="imgprincipal" name="imgprincipal[]" onchange="carregarImgPrincipal();">

                            </div>

                        </div>

                        <div class="col-md-6" align="right">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal" id="btn-cancelar">Cancelar</button>
                            <%id = request.getParameter("id");%>
                            <input type="hidden" id="id"  name="id" value="<%=id%>" required>

                            <button type="submit" id="btn-principal" name="btn-principal" class="btn btn-info">Salvar</button>

                        </div>

                    </div>

                    <div class="col-md-12 mb-2">
                        <img src="../img/imoveis/<%=imgPrincipal%>" alt="Carregue sua Imagem" id="targetPrincipal" width="100%">
                    </div>


                    <div align="center" id="mensagem_img" class="">

                    </div>
                </form>
            </div>

        </div>
    </div>
</div>         




<div class="modal" id="modalPlanta" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Foto Planta</h5>
                <button type="button" class="close"  data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="form-planta" method="POST" enctype="multipart/form-data" >
                    <div class="row">
                        <div class="col-md-6">
                            <div class="col-md-12 form-group">
                                <label>Foto Planta</label>
                                <input value="<%=imgPlanta%>" type="file" class="form-control-file" id="imgplanta" name="imgplanta[]" onchange="carregarImgPlanta();">

                            </div>

                        </div>

                        <div class="col-md-6" align="right">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal" id="btn-cancelar-planta">Cancelar</button>
                            <%id = request.getParameter("id");%>
                            <input type="hidden" id="id"  name="id" value="<%=id%>" required>

                            <button type="submit" id="btn-planta" name="btn-planta" class="btn btn-info">Salvar</button>

                        </div>

                    </div>

                    <div class="col-md-12 mb-2">
                        <img src="../img/imoveis/<%=imgPlanta%>" alt="Carregue sua Imagem" id="targetPlanta" width="100%">
                    </div>


                    <div align="center" id="mensagem_img" class="">

                    </div>
                </form>
            </div>

        </div>
    </div>
</div>                    





<div class="modal" id="modalBanner" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Foto Banner</h5>
                <button type="button" class="close"  data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="form-banner" method="POST" enctype="multipart/form-data" >
                    <div class="row">
                        <div class="col-md-6">
                            <div class="col-md-12 form-group">
                                <label>Foto Banner (1280x720)</label>
                                <input value="<%=imgBanner%>" type="file" class="form-control-file" id="imgbanner" name="imgbanner[]" onchange="carregarImgBanner();">

                            </div>

                        </div>

                        <div class="col-md-6" align="right">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal" id="btn-cancelar-banner">Cancelar</button>
                            <%id = request.getParameter("id");%>
                            <input type="hidden" id="id"  name="id" value="<%=id%>" required>

                            <button type="submit" id="btn-banner" name="btn-banner" class="btn btn-info">Salvar</button>

                        </div>

                    </div>

                    <div class="col-md-12 mb-2">
                        <img src="../img/imoveis/<%=imgBanner%>" alt="Carregue sua Imagem" id="targetBanner" width="100%">
                    </div>


                    <div align="center" id="mensagem_img" class="">

                    </div>
                </form>
            </div>

        </div>
    </div>
</div>           





<div class="modal" id="modalFotos" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Imagens do Imóvel</h5>
                <button type="button" class="close"  data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="form-fotos" method="POST" enctype="multipart/form-data" >
                    <div class="row">
                        <div class="col-md-5">
                            <div class="col-md-12 form-group">
                                <label>Imagens do Imóvel</label>
                                <input type="file" class="form-control-file" id="imgimovel" name="imgimovel[]" onchange="carregarImgImovel();">

                            </div>

                            <div class="col-md-12 mb-2">
                                <img src="../img/imoveis/sem-img.jpg" alt="Carregue sua Imagem" id="targetImovel" width="100%">
                            </div>

                        </div>

                        <div class="col-md-7" id="listar-img">

                        </div>




                    </div>

                    <div class="col-md-12" align="right">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal" id="btn-cancelar-fotos">Cancelar</button>
                        <%id = request.getParameter("id");%>
                        <input type="hidden" id="id"  name="id" value="<%=id%>" required>

                        <button type="submit" id="btn-fotos" name="btn-fotos" class="btn btn-info">Salvar</button>

                    </div>


                    <small>     
                        <div align="center" id="mensagem_fotos" class="">

                        </div>
                    </small>   
                </form>
            </div>

        </div>
    </div>
</div>   






<div class="modal" id="modalDeletarImg" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Excluir Registro</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <p>Deseja realmente Excluir esta Imagem?</p>

                <div align="center" id="mensagem_excluir_img" class="">

                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal" id="btn-cancelar-img">Cancelar</button>
                <form method="post">
                    <input type="hidden" name="id_foto" id="id_foto">                  
                    <button type="button" id="btn-deletar-img" name="btn-deletar-img" class="btn btn-danger">Excluir</button>
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

<%    if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("imagens")) {

        out.print("<script>$('#modal-imagens').modal('show');</script>");
    }

%>  



<!--SCRIPT PARA EXECUTAR ALGUMAS TAREFAS AO INICIAR -->
<script type="text/javascript">
    $(document).ready(function () {
        listarImagens();

    });
</script>

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





<!--EXECUÇÃO DO SUBMIT DO FORM -->
<script type="text/javascript">

    $("#form").submit(function () {

        event.preventDefault();

        //var formData = new FormData(this);


    });
</script>




<!--AJAX PARA EXECUTAR A EDIÇÃO DA IMAGEM FOTO PRINCIPAL -->
<script type="text/javascript">


    $("#form-principal").submit(function () {

        var pag = "<%=pag%>";
        event.preventDefault();
        var formData = new FormData(this);

        $.ajax({
            url: pag + "/foto-principal.jsp",
            type: 'POST',
            data: formData,

            success: function (mensagem) {

                $('#mensagem_img').removeClass()

                if (mensagem.trim() == "Salvo com Sucesso!!") {
                    $('#mensagem_img').addClass('text-success');
                    //$('#nome').val('');
                    //$('#cpf').val('');
                    $('#btn-cancelar').click();
                    //window.location = "index.jsp?pag=" + pag;

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





<!--AJAX PARA EXECUTAR A EDIÇÃO DA IMAGEM FOTO PLANTA -->
<script type="text/javascript">


    $("#form-planta").submit(function () {

        var pag = "<%=pag%>";
        event.preventDefault();
        var formData = new FormData(this);

        $.ajax({
            url: pag + "/foto-planta.jsp",
            type: 'POST',
            data: formData,

            success: function (mensagem) {

                $('#mensagem_img').removeClass()

                if (mensagem.trim() == "Salvo com Sucesso!!") {
                    $('#mensagem_img').addClass('text-success');
                    //$('#nome').val('');
                    //$('#cpf').val('');
                    $('#btn-cancelar-planta').click();
                    //window.location = "index.jsp?pag=" + pag;

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





<!--AJAX PARA EXECUTAR A EDIÇÃO DA IMAGEM FOTO BANNER -->
<script type="text/javascript">


    $("#form-banner").submit(function () {

        var pag = "<%=pag%>";
        event.preventDefault();
        var formData = new FormData(this);

        $.ajax({
            url: pag + "/foto-banner.jsp",
            type: 'POST',
            data: formData,

            success: function (mensagem) {

                $('#mensagem_img').removeClass()

                if (mensagem.trim() == "Salvo com Sucesso!!") {
                    $('#mensagem_img').addClass('text-success');
                    //$('#nome').val('');
                    //$('#cpf').val('');
                    $('#btn-cancelar-banner').click();
                    //window.location = "index.jsp?pag=" + pag;

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





<!--AJAX PARA EXECUTAR A INSERÇÃO DAS DEMAIS FOTOS DO IMÓVEL -->
<script type="text/javascript">


    $("#form-fotos").submit(function () {

        var pag = "<%=pag%>";
        event.preventDefault();
        var formData = new FormData(this);

        $.ajax({
            url: pag + "/fotos-imovel.jsp",
            type: 'POST',
            data: formData,

            success: function (mensagem) {

                $('#mensagem_fotos').removeClass()

                if (mensagem.trim() == "Salvo com Sucesso!!") {
                    $('#mensagem_fotos').addClass('text-success');
                    //$('#nome').val('');
                    //$('#cpf').val('');
                    //$('#btn-cancelar-fotos').click();
                    listarImagens();

                } else {

                    $('#mensagem_fotos').addClass('text-danger')

                }

                $('#mensagem_fotos').text(mensagem)

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




<!--AJAX PARA EXCLUSÃO DAS FOTOS DOS IMOVEIS -->
<script type="text/javascript">
    $(document).ready(function () {
        var pag = "<%=pag%>";
        $('#btn-deletar-img').click(function (event) {
            event.preventDefault();

            $.ajax({
                url: pag + "/excluir-foto.jsp",
                method: "post",
                data: $('form').serialize(),
                dataType: "text",
                success: function (mensagem) {

                    if (mensagem.trim() === 'Excluído com Sucesso!!') {


                        $('#btn-cancelar-img').click();
                        listarImagens();
                    }

                    $('#mensagem_excluir_img').text(mensagem)



                },

            })
        })
    })
</script>



<!--AJAX PARA LISTAR OS DADOS DO VENDEDOR -->
<script type="text/javascript">
    $(document).ready(function () {
        var idImov = "<%=idImov%>";
        if (idImov == null) {
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
        }

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
        var idImov = "<%=idImov%>";
        console.log(idImov)
        if (idImov === "null") {
            document.getElementById('doc').value = "";
            document.getElementById('btn-salvar').disabled = true;

            document.getElementById('valor').value = "0";
            document.getElementById('ano').value = "0";
            document.getElementById('area').value = "0";
            document.getElementById('quartos').value = "0";
            document.getElementById('banheiros').value = "0";
            document.getElementById('suites').value = "0";
            document.getElementById('garagens').value = "0";
            document.getElementById('piscinas').value = "0";
        }


        $('#vendedor').change(function () {

            if (idImov == null) {
                if ($(this).val() === '0') {
                    document.getElementById('doc').value = "";
                    document.getElementById('nomeVendedor').value = "";
                    document.getElementById('btn-salvar').disabled = true;
                } else {
                    document.getElementById('btn-salvar').disabled = false;
                }
            }

            $('#btn-buscar').click();


        });

    })
</script>



<!--AJAX PARA LISTAR OS DADOS DO BAIRRO NO SELECT -->
<script type="text/javascript">
    $(document).ready(function () {

        document.getElementById('txtcidade').value = document.getElementById('cidade').value;

        $('#btn-buscar-bairro').click();

        var pag = "<%=pag%>";
        $.ajax({
            url: pag + "/listar-bairros.jsp",
            method: "post",
            data: $('form').serialize(),
            dataType: "html",
            success: function (result) {

                $('#listar-bairros').html(result);
            }
        })

    })
</script>


<!-- Script para buscar pelo select -->
<script type="text/javascript">

    $('#cidade').change(function () {

        document.getElementById('txtcidade').value = $(this).val();
        document.getElementById('txtbairro').value = $(this).val();
        $('#btn-buscar-bairro').click();
    })

</script>




<!--AJAX PARA BUSCAR DADOS PELO BOTÃO BAIRROS -->
<script type="text/javascript">

    $('#btn-buscar-bairro').click(function (event) {
        var pag = "<%=pag%>";

        $.ajax({
            url: pag + "/listar-bairros.jsp",
            method: "post",
            data: $('form').serialize(),
            dataType: "html",
            success: function (result) {

                $('#listar-bairros').html(result);
            }
        })
    })


</script>



<!--FUNCAO PARA CHAMAR MODAL DE DELETAR IMAGEM DAS FOTOS -->
<script type="text/javascript">
    function deletarImg(img) {
        document.getElementById('id_foto').value = img;
        $('#modalDeletarImg').modal('show');
    }
</script>

<!--AJAX PARA LISTAR OS DADOS DAS IMAGENS DOS IMÓVEIS NA MODAL -->
<script type="text/javascript">

    function listarImagens() {
        var pag = "<%=pag%>";
        $.ajax({
            url: pag + "/listar-imagens.jsp",
            method: "post",
            data: $('form').serialize(),
            dataType: "html",
            success: function (result) {

                $('#listar-img').html(result);
            }
        })
    }



</script>




<!--SCRIPT PARA TROCAR As IMAGEns  -->
<script type="text/javascript">

    function carregarImgPrincipal() {

        var target = document.getElementById('targetPrincipal');
        var file = document.querySelector("input[id=imgprincipal]").files[0];
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


    function carregarImgPlanta() {

        var target = document.getElementById('targetPlanta');
        var file = document.querySelector("input[id=imgplanta]").files[0];
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

    function carregarImgBanner() {

        var target = document.getElementById('targetBanner');
        var file = document.querySelector("input[id=imgbanner]").files[0];
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



    function carregarImgImovel() {

        var target = document.getElementById('targetImovel');
        var file = document.querySelector("input[id=imgimovel]").files[0];
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


<!--ATUALIZAR PÁGINA APÓS FECHAR MODAL DAS IMAGENS -->
<script type="text/javascript">
    var pag = "<%=pag%>";
    $('#btn-fechar-imagens').click(function (event) {

        window.location = "index.jsp?pag=" + pag;

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