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

    double entradas = 0;
    double saidas = 0;
    double total = 0;

    String valorEntradas = "";
    String valorSaidas = "";
    String valorTotal = "";
    String classeValor = "";
    String classeValor2 = "";

    int totalMovimentacoes = 0;
    int vencimentosHoje = 0;
    int recebimentosHoje = 0;
    int contasVencidas = 0;
    int recebimentosVencidos = 0;

    st = new Conexao().conectar().createStatement();
    st2 = new Conexao().conectar().createStatement();
    st3 = new Conexao().conectar().createStatement();

    //TOTALIZANDO VALORES
    rs = st.executeQuery("SELECT * FROM movimentacoes where data = curDate()");
    String vlr = "";
    String tip = "";
    while (rs.next()) {

        tip = rs.getString(2);
        if (tip.equals("Entrada")) {
            vlr = rs.getString(4);
            entradas = entradas + Double.parseDouble(vlr);
            valorEntradas = (NumberFormat.getCurrencyInstance().format(entradas));

        } else {
            vlr = rs.getString(4);
            saidas = saidas + Double.parseDouble(vlr);
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

    //Trazer total de movimentacoes hoje
    rs = st.executeQuery("SELECT * FROM movimentacoes where data = curDate() ");
    while (rs.next()) {
        totalMovimentacoes = totalMovimentacoes + 1;
    }

    rs = st.executeQuery("SELECT * FROM contas_pagar where data = curDate() and pago = 'Não' ");
    while (rs.next()) {
        vencimentosHoje = vencimentosHoje + 1;
    }

    rs = st.executeQuery("SELECT * FROM contas_receber where data = curDate() and pago = 'Não' ");
    while (rs.next()) {
        recebimentosHoje = recebimentosHoje + 1;
    }

    rs = st.executeQuery("SELECT * FROM contas_pagar where data < curDate() and pago = 'Não' ");
    while (rs.next()) {
        contasVencidas = contasVencidas + 1;
    }

    rs = st.executeQuery("SELECT * FROM contas_receber where data < curDate() and pago = 'Não' ");
    while (rs.next()) {
        recebimentosVencidos = recebimentosVencidos + 1;
    }


%>




<div class="row">

    <!-- Earnings (Monthly) Card Example -->
    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card border-left-primary shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Movimentações Hoje</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%=totalMovimentacoes%></div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-coins fa-2x text-primary"></i>
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
                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Entradas do Dia</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%=valorEntradas%></div>
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
        <div class="card border-left-danger shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-danger text-uppercase mb-1">Saídas do Dia</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%=valorSaidas%></div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-dollar-sign fa-2x text-danger"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Pending Requests Card Example -->
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
</div>


<div class="text-xs font-weight-bold text-secondary text-uppercase mt-4">Informações de Contas</div>
<hr> 

<div class="row">


    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card border-left-warning shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Vencimentos Hoje</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%=vencimentosHoje%></div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-calendar-day fa-2x text-warning"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card border-left-success shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Recebimento Hoje</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%=recebimentosHoje%></div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-calendar-day fa-2x text-success"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card border-left-danger shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-danger text-uppercase mb-1">Contas Vencidas</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%=contasVencidas%></div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-calendar-alt fa-2x text-danger"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card border-left-secondary shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-secondary text-uppercase mb-1">Recebimentos Vencidos</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%=recebimentosVencidos%></div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-calendar-alt fa-2x text-secondary"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>




</div>