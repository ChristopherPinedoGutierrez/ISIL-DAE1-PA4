<%@page import="pe.isil.dae_01_pa4.model.beans.Academia"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="pe.isil.dae_01_pa4.business_logic.BL_Karateca" %> 
<%@ page import="pe.isil.dae_01_pa4.model.beans.Karateca" %>
<%@ page import="pe.isil.dae_01_pa4.model.beans.Llave" %>
<%@ page import="java.util.ArrayList" %>

<%
    ArrayList<Llave> llaves = (ArrayList<Llave>) request.getAttribute("llaves");
    String mensaje = (String) request.getAttribute("mensaje");
    String error = (String) request.getAttribute("error");
    BL_Karateca blK = new BL_Karateca();
    List<Karateca> karatecasOrdenados = (List<Karateca>) request.getAttribute("karatecasOrdenados");
    Karateca campeon = (Karateca) request.getAttribute("campeon");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Lista de Participantes - Llaves del Torneo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container py-5">
    <section class="mb-5">
        <h2 class="text-primary mb-4">Generación de llaves del torneo</h2>

        <% if (mensaje != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <%= mensaje %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>
        
        <section>
        <h4 class="mb-3">Karatecas ordenados secuencialmente por edad, peso y rango</h4>
        <div class="table-responsive rounded-4 shadow-sm">
            <table class="table table-bordered table-hover align-middle mb-0">
                <thead class="table-dark text-center">
                    <tr>
                        <th>Nro</th>
                        <th>Nombre</th>
                        <th>Edad</th>
                        <th>Peso</th>
                        <th>Rango</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Karateca> lista = (List<Karateca>) request.getAttribute("karatecasOrdenados");
                        int nro = 1;
                        if (lista != null) {
                            for (Karateca k : lista) {
                    %>
                        <tr>
                            <td><%= nro++ %></td>
                            <td><%= k.getNombreCompleto() %></td>
                            <td><%= k.getEdad() %></td>
                            <td><%= k.getPeso() %></td>
                            <td><%= k.getRango() %></td>
                        </tr>
                    <%
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </section>

        <form action="<%=request.getContextPath()%>/llave" method="post" class="card p-4 shadow rounded-4 bg-white border-0 mb-4">
            <input type="hidden" name="action" value="generar">
            <div class="d-flex justify-content-between">
                <button type="submit" class="btn btn-primary px-4">Generar</button>
                <a href="<%=request.getContextPath()%>/index.jsp" class="btn btn-outline-secondary">Volver al inicio</a>
            </div>
        </form>
    </section>

    <section>
        <div class="card shadow-sm rounded-4">
            <div class="card-body">
                <h5 class="card-title fw-semibold mb-3">Lista de Llaves Generadas</h5>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover align-middle mb-0">
                        <thead class="table-dark text-center">
                            <tr>
                                <th>#</th>
                                <th>Karateca 1</th>
                                <th>Karateca 2</th>
                                <th>Ronda</th>
                                <th>Ganador</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                int contador = 1;
                                if (llaves != null && !llaves.isEmpty()) {
                                    for (Llave l : llaves) {
                                        Karateca k1 = blK.getById(l.getIdKarateca1());
                                        Karateca k2 = blK.getById(l.getIdKarateca2());
                                        Karateca ganadorK = l.getGanador() != null ? blK.getById(l.getGanador()) : null;
                                        String nombreK1 = k1 != null ? k1.getNombreCompleto() : "Desconocido";
                                        String nombreK2 = k2 != null ? k2.getNombreCompleto() : "Desconocido";
                                        String nombreGanador = (ganadorK != null) ? ganadorK.getNombreCompleto() : "Sin definir";
                            %>
                            <tr>
                                <td class="text-center"><%= contador++ %></td>
                                <td><%= nombreK1 %></td>
                                <td><%= nombreK2 %></td>
                                <td class="text-center"><%= l.getRonda() %></td>
                                <td><%= nombreGanador %></td>
                            </tr>
                            <%      }
                                } else {
                            %>
                            <tr>
                                <td colspan="5" class="text-center text-muted">No se han generado llaves aún.</td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </section>
                        
    <section class="mt-5">
        <div class="card shadow-sm rounded-4">
            <div class="card-body">
                <h5 class="card-title fw-semibold mb-3 text-success">Campeón del Torneo</h5>
                <%
                    if (campeon != null) {
                %>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover align-middle mb-0">
                        <thead class="table-success text-center">
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>DNI</th>
                                <th>Edad</th>
                                <th>Peso</th>
                                <th>Sexo</th>
                                <th>Rango</th>
                                <th>Modalidad</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><%= campeon.getIdKarateca() %></td>
                                <td><%= campeon.getNombreCompleto() %></td>
                                <td><%= campeon.getDni() %></td>
                                <td><%= campeon.getEdad() %></td>
                                <td><%= campeon.getPeso() %></td>
                                <td><%= campeon.getSexo() %></td>
                                <td><%= campeon.getRango() %></td>
                                <td><%= campeon.getModalidad() %></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <% } else { %>
                <p class="text-center text-muted mb-0">No hay campeón aún.</p>
                <% } %>
            </div>
        </div>
    </section>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
