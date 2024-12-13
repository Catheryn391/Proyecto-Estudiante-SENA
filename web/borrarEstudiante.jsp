<%-- 
    Document   : borrarEstudiante.jsp
    Created on : 12/12/2024, 8:58:00 p. m.
    Author     : Catheryn
--%>
<%@page import ="proyecto.EstudianteCRUD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String docEst = request.getParameter("doc_est");

    if (docEst != null) {
        EstudianteCRUD crud = new EstudianteCRUD();
        crud.borrarEstudiante(docEst);
        response.sendRedirect("index.jsp"); // Redirect back to the main page
    } else {
        out.println("<p>Error: No se pudo borrar el estudiante.</p>");
    }
%>