<%@page import="java.util.Calendar"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>
<%@page import="java.text.NumberFormat"%> 
<%@page import="java.sql.*"%>


<%
    String cpfUsuario = (String) session.getAttribute("cpfUsuario");
    //recuperar data atual
    Date dataAtual = new Date(System.currentTimeMillis());

    //recuperar dia, mes e ano
    Calendar cal = Calendar.getInstance();
    int day = cal.get(Calendar.DATE);
    int month = cal.get(Calendar.MONTH) + 1;
    int year = cal.get(Calendar.YEAR);

    String dataInicioMes = year + "/" + month + "/01";
    //out.print(dataInicioMes);

    Statement st = null;
    ResultSet rs = null;

    Statement st2 = null;
    ResultSet rs2 = null;

    Statement st3 = null;
    ResultSet rs3 = null;

    int totalTarefas = 0;
    int totalImoveis = 0;
    int totalVendasMes = 0;
    double totalArrecadadoMes = 0;

    String totalArrecadado = "";

    st = new Conexao().conectar().createStatement();
    st2 = new Conexao().conectar().createStatement();
    st3 = new Conexao().conectar().createStatement();

    //Trazer total de imóveis cadastrados
    rs = st.executeQuery("SELECT * FROM imoveis where (status = 'Para Venda' or status = 'Para Aluguel') and corretor = '" + cpfUsuario + "' ");
    while (rs.next()) {
        totalImoveis = totalImoveis + 1;
    }

    //Trazer total de visitas para hoje
    rs = st.executeQuery("SELECT * FROM tarefas where corretor = '" + cpfUsuario + "' and data = curDate() ");
    while (rs.next()) {
        totalTarefas = totalTarefas + 1;
    }

    //Trazer total de vendas mes
    rs = st.executeQuery("SELECT * FROM vendas where data >= '" + dataInicioMes + "' and data <= curDate() ");
    while (rs.next()) {
        totalVendasMes = totalVendasMes + 1;
    }

    //Trazer total arrecadado R$ mes
    rs = st.executeQuery("SELECT * FROM entradas where data >= '" + dataInicioMes + "' and data <= curDate() ");
    String valr = "";
    while (rs.next()) {
        valr = rs.getString(5);
        totalArrecadadoMes = totalArrecadadoMes + Double.parseDouble(valr);
        totalArrecadado = (NumberFormat.getCurrencyInstance().format(totalArrecadadoMes));

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
        <div class="card border-left-success shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Total Arrecadado</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%=totalArrecadado%></div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-dollar-sign fa-2x text-success"></i>
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
                        <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Tarefas Hoje</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%=totalTarefas%></div>
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
                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Vendas no mês</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%=totalVendasMes%></div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-users fa-2x text-warning"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="text-xs font-weight-bold text-secondary text-uppercase mt-4">Agenda do Dia</div>
<hr> 

<div class="row">

    <%
        try {

            String titulo = "";
            String descricao = "";
            String data = "";
            String hora = "";
            String imovel = "";
            String classe1 = "";
            String classe2 = "";
            String status = "";

            st = new Conexao().conectar().createStatement();
            rs = st.executeQuery("SELECT * FROM tarefas where corretor = '" + cpfUsuario + "' and data = curDate() order by hora asc ");
            while (rs.next()) {
                titulo = rs.getString(2);
                descricao = rs.getString(3);
                hora = rs.getString(5);
                status = rs.getString(8);

                if (status.equals("")) {
                    classe1 = "text-danger";
                    classe2 = "border-left-danger";
                } else {
                    classe1 = "text-success";
                    classe2 = "border-left-success";
                }


    %>

    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card <%=classe2%> shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold  <%=classe1%> text-uppercase"><%=titulo%></div>
                        <div class="text-xs text-secondary"><%=descricao%></div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-clock fa-2x  <%=classe1%>"></i><br>
                        <span class="text-xs"><%=hora%></span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%  }
        } catch (Exception e) {
            out.print(e);
        }
    %>
</div>

