<!-- Content Row -->

<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>
<%@page import="java.text.NumberFormat"%> 
<%@page import="java.sql.*"%>


<%
    String cpfUsuario = (String) session.getAttribute("cpfUsuario");
    Statement st = null;
    ResultSet rs = null;

    Statement st2 = null;
    ResultSet rs2 = null;

    Statement st3 = null;
    ResultSet rs3 = null;

    int totalImoveis = 0;
    int totalCorretores = 0;
    int totalVendas = 0;
    int totalVisitas = 0;
    
    
    double entradas = 0;
    double saidas = 0;
    double total = 0;

    String valorEntradas = "";
    String valorSaidas = "";
    String valorTotal = "";
    String classeValor = "";
    String classeValor2 = "";
    

    st = new Conexao().conectar().createStatement();
    st2 = new Conexao().conectar().createStatement();
    st3 = new Conexao().conectar().createStatement();

    //Trazer total de imóveis cadastrados
    rs = st.executeQuery("SELECT * FROM imoveis where status = 'Para Venda' or status = 'Para Aluguel' ");
    while (rs.next()) {
        totalImoveis = totalImoveis + 1;
    }

    //Trazer total de visitas para hoje
    rs = st.executeQuery("SELECT * FROM tarefas where id_imovel != '' and data = curDate() ");
    while (rs.next()) {
        totalVisitas = totalVisitas + 1;
    }

    //Trazer total de corretores cadastrados
    rs = st.executeQuery("SELECT * FROM corretores ");
    while (rs.next()) {
        totalCorretores = totalCorretores + 1;
    }
    


     //TOTALIZANDO VALORES
    rs = st.executeQuery("SELECT * FROM movimentacoes where data = curDate()");
    String valr = "";
    String tip = "";
    while (rs.next()) {

        tip = rs.getString(2);
        if (tip.equals("Entrada")) {
            valr = rs.getString(4);
            entradas = entradas + Double.parseDouble(valr);
            valorEntradas = (NumberFormat.getCurrencyInstance().format(entradas));

        } else {
            valr = rs.getString(4);
            saidas = saidas + Double.parseDouble(valr);
            valorSaidas = (NumberFormat.getCurrencyInstance().format(saidas));

        }

        total = entradas - saidas;
        if (total < 0) {
            classeValor = "text-danger";
            classeValor2 = "border-left-danger";

        } else {
            classeValor = "text-success";
            classeValor2 = "border-left-success";
        }

        valorTotal = (NumberFormat.getCurrencyInstance().format(total));

    }


%>


<div class="row">

    <!-- Earnings (Monthly) Card Example -->
    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card border-left-primary shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Imóveis Cadastrados</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%=totalImoveis%></div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-home fa-2x text-primary"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Earnings (Monthly) Card Example -->
    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card <%=classeValor2%> shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold <%=classeValor%> text-uppercase mb-1">Saldo do Dia</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%=valorTotal%></div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-dollar-sign fa-2x <%=classeValor%>"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Earnings (Monthly) Card Example -->
    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card border-left-info shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Visitas para Hoje</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%=totalVisitas%></div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-clipboard-list fa-2x text-info"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Pending Requests Card Example -->
    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card border-left-warning shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Corretores</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%=totalCorretores%></div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-users fa-2x text-warning"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>



<div class="row">

    <!-- Início dos cards -->

    <%    try {

            String status = "";
            String imagem = "";
            String valor = "";
            String titulo = "";
            String bairro = "";
            String area = "";
            String quartos = "";
            String banheiros = "";
            String garagens = "";
            String corretor = "";
            String id = "";

            String nomeCorretor = "";
            String telefoneCorretor = "";
            String imgCorretor = "";
            String nomeBairro = "";

            String classe = "";

            rs = st.executeQuery("SELECT * FROM imoveis where status = 'Para Venda' or status = 'Para Aluguel' order by id desc limit 4");
            while (rs.next()) {
                status = rs.getString(22);
                imagem = rs.getString(18);
                valor = rs.getString(9);
                titulo = rs.getString(4);
                bairro = rs.getString(8);
                area = rs.getString(12);
                quartos = rs.getString(13);
                banheiros = rs.getString(14);
                garagens = rs.getString(16);
                corretor = rs.getString(3);

                double vlr = 0;
                vlr = Double.parseDouble(valor);
                valor = (NumberFormat.getCurrencyInstance().format(vlr));

                id = rs.getString(1);

                rs2 = st2.executeQuery("SELECT * FROM corretores where cpf = '" + corretor + "'");
                while (rs2.next()) {
                    nomeCorretor = rs2.getString(2);
                    telefoneCorretor = rs2.getString(4);
                    imgCorretor = rs2.getString(7);
                }

                rs3 = st3.executeQuery("SELECT * FROM bairros where id = '" + bairro + "'");
                while (rs3.next()) {
                    nomeBairro = rs3.getString(2);

                }

                if (status.equals("Para Venda")) {
                    classe = "c-red";
                } else {
                    classe = "";
                }

    %>

    <div class="col-lg-3 col-md-4 col-md-12 mb-4">
        
          <img width="245" height="160" src="../img/imoveis/<%=imagem%>">

            <div class="mt-2">
                <span class="text-dark"><%=titulo%></span><br>
                <span class="text-success"> <%=valor%></span>

               
                    
                        <div class="row mt-3">
                            <div class="col-md-3">
                                <img class="rounded-circle" width="50" src="../img/profiles/<%=imgCorretor%>" alt="">
                            </div>
                            <div class="col-md-9">
                                <span><%=nomeCorretor%></span><br>
                                <span class="text-muted"><small><%=telefoneCorretor%></small></span>
                            </div>


                        </div>

                   
               
        </div>
    </div>


    <%  }
        } catch (Exception e) {
            out.print(e);
        }
    %>

    <!-- Fim dos Cards com os Imóveis -->   

</div>                   