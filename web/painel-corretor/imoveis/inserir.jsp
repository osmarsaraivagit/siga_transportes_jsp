<%@page import="util.Upload" %>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>


<%
    String cpfUsuario = (String) session.getAttribute("cpfUsuario");

    Statement st = null;
    ResultSet rs = null;

    String nomeVendedor = "";

    String vendedor = "";
    String corretor = "";
    String titulo = "";
    String descricao = "";
    String tipo = "";
    String cidade = "";
    String bairro = "";
    String valor = "";
    String ano = "";
    String area = "";
    String quartos = "";
    String banheiros = "";
    String suites = "";
    String garagens = "";
    String piscinas = "";
    String imgPrincipal = null;
    String imgPlanta = null;
    String imgBanner = null;
    String endereco = "";
    String status = "";
    String condicao = "";

    String id = "";

    nomeVendedor = request.getParameter("nomeVendedor");

    vendedor = request.getParameter("doc");
    corretor = cpfUsuario;
    titulo = request.getParameter("titulo");
    descricao = request.getParameter("descricao");
    tipo = request.getParameter("tipo");
    cidade = request.getParameter("cidade");
    bairro = request.getParameter("bairro");
    valor = request.getParameter("valor");
    valor = valor.replace(",", ".");
    ano = request.getParameter("ano");
    area = request.getParameter("area");
    quartos = request.getParameter("quartos");
    banheiros = request.getParameter("banheiros");
    suites = request.getParameter("suites");
    garagens = request.getParameter("garagens");
    piscinas = request.getParameter("piscinas");
    endereco = request.getParameter("endereco");
    status = request.getParameter("status");
    condicao = request.getParameter("condicao");
    id = request.getParameter("txtid");

    String quantImoveis = "";
    int totalImoveis = 0;

    //recuperar a quantidade de imoveis do tipo
    st = new Conexao().conectar().createStatement();
    rs = st.executeQuery("SELECT * FROM tipos where id = '" + tipo + "' ");

    while (rs.next()) {
        quantImoveis = rs.getString(4);
    }
    totalImoveis = Integer.parseInt(quantImoveis) + 1;

    //verificar se o campo é vazio
    if (!id.equals("")) {
        if (nomeVendedor.equals("")) {
            out.print("Selecione um Cliente Vendedor!!");
            return;
        }
    }

    if (valor.equals("")) {
        out.print("Insira o Valor!!");
        return;
    }

    if (ano.equals("")) {
        out.print("Insira o Ano!!");
        return;
    }

    if (area.equals("")) {
        out.print("Insira a Área!!");
        return;
    }

    if (quartos.equals("")) {
        out.print("Insira os Quartos!!");
        return;
    }

    if (banheiros.equals("")) {
        out.print("Insira os Banheiros!!");
        return;
    }

    if (suites.equals("")) {
        out.print("Insira as Suites!!");
        return;
    }

    if (garagens.equals("")) {
        out.print("Insira as Garagens!!");
        return;
    }

    if (piscinas.equals("")) {
        out.print("Insira as Piscinas!!");
        return;
    }

    //INSERIR OS DADOS NO BANCO DE DADOS
    try {

        st = new Conexao().conectar().createStatement();

        if (id.equals("")) {

            st.executeUpdate("INSERT into imoveis (vendedor, corretor, titulo, descricao, tipo, cidade, bairro, valor, ano, visitas, area, quartos, banheiros, suites, garagens, piscinas, img_principal, img_planta, img_banner, endereco, status, condicao) values ('" + vendedor + "', '" + corretor + "' , '" + titulo + "' , '" + descricao + "', '" + tipo + "', '" + cidade + "', '" + bairro + "', '" + valor + "', '" + ano + "', '0', '" + area + "', '" + quartos + "', '" + banheiros + "', '" + suites + "', '" + garagens + "', '" + piscinas + "', 'sem-img.jpg', 'sem-img.jpg', 'sem-img.jpg', '" + endereco + "', '" + status + "', '" + condicao + "')");
            //atualizar na tabela tipos o total de imovel do tipo
            st.executeUpdate("UPDATE tipos SET imoveis = '" + totalImoveis + "' WHERE id = '" + tipo + "'");

        } else {

            st.executeUpdate("UPDATE imoveis SET vendedor = '" + vendedor + "', corretor = '" + corretor + "', titulo = '" + titulo + "', descricao = '" + descricao + "', tipo = '" + tipo + "', cidade = '" + cidade + "', bairro = '" + bairro + "', valor = '" + valor + "', ano = '" + ano + "',  area = '" + area + "',  quartos = '" + quartos + "',  banheiros = '" + banheiros + "',  garagens = '" + garagens + "',  suites = '" + suites + "',  piscinas = '" + piscinas + "',  endereco = '" + endereco + "',  status = '" + status + "',  condicao = '" + condicao + "' WHERE id = '" + id + "'");

            if (status.equals("Vendido")) {
                rs = st.executeQuery("SELECT * FROM vendas where imovel = '" + id + "' ");
                if (rs.last() == false) {
                    st.executeUpdate("INSERT into vendas (imovel, corretor, valor, pago, data) values ('" + id + "', '" + cpfUsuario + "' , '" + valor + "' , 'Não', curDate())");
                    
                }
            }
            
            
            if (status.equals("Alugado")) {
                rs = st.executeQuery("SELECT * FROM alugueis where imovel = '" + id + "' ");
                if (rs.last() == false) {
                    st.executeUpdate("INSERT into alugueis (imovel, corretor, valor, ativo, data) values ('" + id + "', '" + cpfUsuario + "' , '" + valor + "' , 'Não', curDate())");
                    
                }
            }
        }

        out.print("Salvo com Sucesso!!");
    } catch (Exception e) {
        out.print(e);
    }


%>