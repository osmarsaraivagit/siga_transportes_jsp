
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.*"%> 


<%
    Statement st = null;
    ResultSet rs = null;

    String idUsuario = (String) session.getAttribute("idUsuario");
    String nivelUsuario = (String) session.getAttribute("nivelUsuario");

    String email = "";
    String senha = "";
    String nome = "";
    String img = "";
    String cpf = "";
    String twitter = "";
    String facebook = "";
    String descricao = "";
    String endereco = "";
    String telefone = "";

    try {
        st = new Conexao().conectar().createStatement();
        rs = st.executeQuery("SELECT * FROM usuarios where id = '" + idUsuario + "' ");
        while (rs.next()) {
            email = rs.getString(4);
            senha = rs.getString(5);
            nome = rs.getString(2);
            cpf = rs.getString(3);
            img = rs.getString(7);

        }
    } catch (Exception e) {
        out.print(e);
    }

    //TRAZER OS DADOS DO CORRETOR
    try {
        st = new Conexao().conectar().createStatement();
        rs = st.executeQuery("SELECT * FROM tesoureiros where cpf = '" + cpf + "' ");
        while (rs.next()) {
            descricao = rs.getString(8);
            twitter = rs.getString(9);
            facebook = rs.getString(10);
            endereco = rs.getString(6);
            telefone = rs.getString(4);

            if (descricao == null) {
                descricao = "";
            }
            if (twitter == null) {
                twitter = "";
            }
            if (facebook == null) {
                facebook = "";
            }
        }
    } catch (Exception e) {
        out.print(e);
    }

    if (nivelUsuario == null || !nivelUsuario.equals("tesoureiro")) {
        response.sendRedirect("../index.jsp");
    }


%>

<%//variaveis para o menu
    String pag = request.getParameter("pag");
    String menu1 = "pagar";
    String menu2 = "receber";
    String menu3 = "movimentacoes";
    String menu4 = "vendas";
    String menu5 = "alugueis";
    String menu6 = "imoveis-vendas";
    String menu7 = "imoveis-alugueis";
    String menu8 = "saidas";
    String menu9 = "compradores";
    String menu10 = "vendedores";

%>

<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="Hugo Vasconcelos">

        <title>Painel Tesoureiro</title>

        <!-- Custom fonts for this template-->
        <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

        <!-- Custom styles for this template-->
        <link href="../css/sb-admin-2.min.css" rel="stylesheet">
        <link href="../css/style.css" rel="stylesheet">

        <link href="../vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">


        <!-- Bootstrap core JavaScript-->
        <script src="../vendor/jquery/jquery.min.js"></script>
        <script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

        <link rel="shortcut icon" href="../../img/favicon0.ico" type="image/x-icon">
        <link rel="icon" href="../../img/favicon0.ico" type="image/x-icon">

    </head>

    <body id="page-top">

        <!-- Page Wrapper -->
        <div id="wrapper">

            <!-- Sidebar -->
            <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

                <!-- Sidebar - Brand -->
                <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.jsp">

                    <div class="sidebar-brand-text mx-3">Tesoureiro</div>
                </a>

                <!-- Divider -->
                <hr class="sidebar-divider my-0">



                <!-- Divider -->
                <hr class="sidebar-divider">

                <!-- Heading -->
                <div class="sidebar-heading">
                    Movimentações
                </div>



                 <li class="nav-item">
                    <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
                        <i class="fas fa-dollar-sign"></i>
                        <span>Pagar / Receber</span>
                    </a>
                    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                        <div class="bg-white py-2 collapse-inner rounded">
                            
                            <a class="collapse-item" href="index.jsp?pag=<%=menu1%>">Contas Pagar</a>
                            <a class="collapse-item" href="index.jsp?pag=<%=menu2%>">Contas Receber</a>
                            <a class="collapse-item" href="index.jsp?pag=<%=menu3%>">Movimentações</a>
                        </div>
                    </div>
                </li>

               

                <!-- Divider -->
                <hr class="sidebar-divider">

                <!-- Heading -->
                <div class="sidebar-heading">
                    Entradas / Saídas
                </div>



                <!-- Nav Item - Charts -->
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp?pag=<%=menu4%>">
                        <i class="fas fa-money-check-alt"></i>
                        <span>Vendas</span></a>
                </li>
                
                 <li class="nav-item">
                    <a class="nav-link" href="index.jsp?pag=<%=menu5%>">
                        <i class="fas fa-money-check"></i>
                        <span>Aluguéis</span></a>
                </li>
                
                 <li class="nav-item">
                    <a class="nav-link" href="index.jsp?pag=<%=menu8%>">
                        <i class="fas fa-coins"></i>
                        <span>Saídas</span></a>
                </li>
                
                
                
                
                <!-- Divider -->
                <hr class="sidebar-divider">

                <!-- Heading -->
                <div class="sidebar-heading">
                    Imóveis Disponíveis
                </div>



                <!-- Nav Item - Charts -->
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp?pag=<%=menu6%>">
                        <i class="fas fa-home"></i>
                        <span>Imóveis Vendas</span></a>
                </li>
                
                 <li class="nav-item">
                    <a class="nav-link" href="index.jsp?pag=<%=menu7%>">
                        <i class="fas fa-house-damage"></i>
                        <span>Imóveis Aluguéis</span></a>
                </li>
                
                 <!-- Divider -->
                <hr class="sidebar-divider">

                <!-- Heading -->
                <div class="sidebar-heading">
                    Consultas
                </div>



                 <li class="nav-item">
                    <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseClientes" aria-expanded="true" aria-controls="collapseTwo">
                        <i class="fas fa-dollar-sign"></i>
                        <span>Vendedores / Clientes</span>
                    </a>
                    <div id="collapseClientes" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                        <div class="bg-white py-2 collapse-inner rounded">
                           
                            <a class="collapse-item" href="index.jsp?pag=<%=menu9%>">Compradores</a>
                            <a class="collapse-item" href="index.jsp?pag=<%=menu10%>">Vendedores</a>
                        </div>
                    </div>
                </li>

               

                <!-- Divider -->
                <hr class="sidebar-divider d-none d-md-block">

                <!-- Sidebar Toggler (Sidebar) -->
                <div class="text-center d-none d-md-inline">
                    <button class="rounded-circle border-0" id="sidebarToggle"></button>
                </div>

            </ul>
            <!-- End of Sidebar -->

            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column">

                <!-- Main Content -->
                <div id="content">

                    <!-- Topbar -->
                    <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                        <!-- Sidebar Toggle (Topbar) -->
                        <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                            <i class="fa fa-bars"></i>
                        </button>



                        <!-- Topbar Navbar -->
                        <ul class="navbar-nav ml-auto">



                            <!-- Nav Item - User Information -->
                            <li class="nav-item dropdown no-arrow">
                                <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <span class="mr-2 d-none d-lg-inline text-gray-600 small"><%= nome%></span>
                                    <img class="img-profile rounded-circle" src="../img/profiles/<%=img%>">

                                </a>
                                <!-- Dropdown - User Information -->
                                <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                                    <a class="dropdown-item" href="" data-toggle="modal" data-target="#ModalPerfil">
                                        <i class="fas fa-user fa-sm fa-fw mr-2 text-primary"></i>
                                        Editar Perfil
                                    </a>

                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="../logout.jsp">
                                        <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-danger"></i>
                                        Sair
                                    </a>
                                </div>
                            </li>

                        </ul>

                    </nav>
                    <!-- End of Topbar -->

                    <!-- Begin Page Content -->
                    <div class="container-fluid">

                        <% if (pag == null) { %>
                        <jsp:include page="home.jsp" />
                        <% } else if (pag.equals(menu1)) {%>
                        <jsp:include page='<%=menu1 + ".jsp"%>' />
                        <% } else if (pag.equals(menu2)) {%>
                        <jsp:include page='<%=menu2 + ".jsp"%>' />
                        
                        <% } else if (pag.equals(menu3)) {%>
                        <jsp:include page='<%=menu3 + ".jsp"%>' />   
                        
                         <% } else if (pag.equals(menu4)) {%>
                        <jsp:include page='<%=menu4 + ".jsp"%>' />  
                        
                         <% } else if (pag.equals(menu5)) {%>
                        <jsp:include page='<%=menu5 + ".jsp"%>' />  
                        
                         <% } else if (pag.equals(menu6)) {%>
                        <jsp:include page='<%=menu6 + ".jsp"%>' />  
                        
                         <% } else if (pag.equals(menu7)) {%>
                        <jsp:include page='<%=menu7 + ".jsp"%>' />  
                        
                         <% } else if (pag.equals(menu8)) {%>
                        <jsp:include page='<%=menu8 + ".jsp"%>' />  
                        
                         <% } else if (pag.equals(menu9)) {%>
                        <jsp:include page='<%=menu9 + ".jsp"%>' />  
                        
                         <% } else if (pag.equals(menu10)) {%>
                        <jsp:include page='<%=menu10 + ".jsp"%>' />  
                        
                        <%  } else {%>
                        <jsp:include page="home.jsp" />
                        <%  }
                        %>

                    </div>
                    <!-- /.container-fluid -->

                </div>
                <!-- End of Main Content -->



            </div>
            <!-- End of Content Wrapper -->

        </div>
        <!-- End of Page Wrapper -->

        <!-- Scroll to Top Button-->
        <a class="scroll-to-top rounded" href="#page-top">
            <i class="fas fa-angle-up"></i>
        </a>




        <!--  Modal Perfil-->
        <div class="modal fade" id="ModalPerfil" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Editar Perfil</h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>



                    <form id="form-perfil" method="POST" enctype="multipart/form-data">
                        <div class="modal-body">

                            <div class="row">
                                <div class="col-md-7 col-sm-12">
                                    <div class="row">
                                        <div class="col-md-6 col-sm-12">
                                            <div class="form-group">
                                                <label >Nome</label>
                                                <input value="<%=nome%>" type="text" class="form-control" id="nome" name="nome" placeholder="Nome">
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-sm-12">
                                            <div class="form-group">
                                                <label >CPF</label>
                                                <input value="<%=cpf%>" type="text" class="form-control" id="cpf" name="cpf" placeholder="CPF">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 col-sm-12">
                                            <div class="form-group">
                                                <label >Email</label>
                                                <input value="<%=email%>" type="email" class="form-control" id="email" name="email" placeholder="Email">
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-sm-12">
                                            <div class="form-group">
                                                <label >Senha</label>
                                                <input value="<%=senha%>" type="password" class="form-control" id="text" name="senha" placeholder="Senha">
                                            </div>
                                        </div>
                                    </div>


                                    <div class="row">
                                        <div class="col-md-6 col-sm-12">
                                            <div class="form-group">
                                                <label >Endereço</label>
                                                <input value="<%=endereco%>" type="text" class="form-control" id="endereco" name="endereco" placeholder="Endereço">
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-sm-12">
                                            <div class="form-group">
                                                <label >Telefone</label>
                                                <input value="<%=telefone%>" type="text" class="form-control" id="telefone" name="telefone" placeholder="Telefone">
                                            </div>
                                        </div>
                                    </div>



                                    <div class="row">
                                        <div class="col-md-6 col-sm-12">
                                            <div class="form-group">
                                                <label >Facebook</label>
                                                <input value="<%=facebook%>" type="text" class="form-control" id="facebook" name="facebook" placeholder="Facebook Link">
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-sm-12">
                                            <div class="form-group">
                                                <label >Twitter</label>
                                                <input value="<%=twitter%>" type="text" class="form-control" id="twitter" name="twitter" placeholder="Twitter Link">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label >Descrição</label>
                                        <textarea maxlength="80" type="text" class="form-control" id="descricao" name="descricao" ><%=descricao%> </textarea>
                                    </div>        








                                </div>
                                <div class="col-md-5 col-sm-12">
                                    <div class="col-md-12 form-group">
                                        <label>Foto</label>
                                        <input value="<%=img%>" type="file" class="form-control-file" id="imagem" name="imagem[]" onchange="carregarImg();">

                                    </div>
                                    <div class="col-md-12 mb-2">
                                        <img src="../img/profiles/<%=img%>" alt="Carregue sua Imagem" id="target" width="100%">
                                    </div>
                                </div>
                            </div> 



                            <small>
                                <div id="mensagem" class="mr-4">

                                </div>
                            </small>



                        </div>
                        <div class="modal-footer">



                            <input value="<%=idUsuario%>" type="hidden" name="txtid" id="txtid">
                            <input value="<%=cpf%>" type="hidden" name="antigo" id="antigo">

                            <button type="button" id="btn-fechar" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                            <button type="submit" name="btn-salvar-perfil" id="btn-salvar-perfil" class="btn btn-primary">Salvar</button>
                        </div>
                    </form>


                </div>
            </div>
        </div>


        <!-- Core plugin JavaScript-->
        <script src="../vendor/jquery-easing/jquery.easing.min.js"></script>

        <!-- Custom scripts for all pages-->
        <script src="../js/sb-admin-2.min.js"></script>

        <!-- Page level plugins -->
        <script src="../vendor/chart.js/Chart.min.js"></script>

        <!-- Page level custom scripts -->
        <script src="../js/demo/chart-area-demo.js"></script>
        <script src="../js/demo/chart-pie-demo.js"></script>

        <!-- Page level plugins -->
        <script src="../vendor/datatables/jquery.dataTables.min.js"></script>
        <script src="../vendor/datatables/dataTables.bootstrap4.min.js"></script>

        <!-- Page level custom scripts -->
        <script src="../js/demo/datatables-demo.js"></script>

    </body>

</html>




<!--SCRIPT PARA SUBIR IMAGEM PARA O SERVIDOR -->
<script type="text/javascript">

                                            function carregarImg() {

                                                var target = document.getElementById('target');
                                                var file = document.querySelector("input[type=file]").files[0];
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




<!--AJAX PARA INSERÇÃO E EDIÇÃO DOS DADOS COM IMAGEM -->
<script type="text/javascript">
    $("#form-perfil").submit(function () {

        event.preventDefault();
        var formData = new FormData(this);

        $.ajax({
            url: "editar-perfil.jsp",
            type: 'POST',
            data: formData,

            success: function (mensagem) {

                $('#mensagem').removeClass()

                if (mensagem.trim() == "Salvo com Sucesso!!") {
                    $('#mensagem').addClass('text-success');
                    //$('#nome').val('');
                    //$('#cpf').val('');
                    $('#btn-fechar').click();
                    window.location = "index.jsp";

                } else {

                    $('#mensagem').addClass('text-danger')
                }

                $('#mensagem').text(mensagem)

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


<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.11/jquery.mask.min.js"></script>

<script src="../../js/mascara.js"></script>