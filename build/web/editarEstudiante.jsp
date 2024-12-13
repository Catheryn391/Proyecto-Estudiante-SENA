<%-- 
    Document   : editarEstudiante.jsp
    Created on : 13/12/2024, 3:43:11 p. m.
    Author     : usuario
--%>
<%@page import ="proyecto.EstudianteCRUD"%>
<%@page import ="proyecto.Estudiante"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    EstudianteCRUD crud = new EstudianteCRUD();
    String docEst = request.getParameter("doc_est");
    String nombreEst = request.getParameter("nombre");
    String apellidoEst = request.getParameter("apellido");
    String edadEst = request.getParameter("edad");

    if (docEst != null && nombreEst != null && apellidoEst != null && edadEst != null) {
        short edadEstudianteEditado = Short.parseShort(edadEst);
        Estudiante estudianteEditado = new Estudiante(docEst, nombreEst, apellidoEst, edadEstudianteEditado);
        crud.editarEstudiante(estudianteEditado, docEst);
    }
    response.sendRedirect("index.jsp");
%>