<%@page import="java.lang.Short"%>
<%@page import ="proyecto.EstudianteCRUD"%>
<%@page import ="proyecto.Estudiante"%>
<%@page import ="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Estudiantes</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            /* Global Styles */
            body {
                font-family: 'Arial', sans-serif;
                background-color: #f4f4f9;
                color: #333;
                margin: 0;
                padding: 0;
            }

            main {
                max-width: 1200px;
                margin: 40px auto;
                padding: 20px;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            h1 {
                text-align: center;
                color: #4CAF50;
            }

            .content {
                margin: 0;
                padding: 0;
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 30px;
                align-items: center;
            }

            form {
                display: flex;
                flex-direction: column;
                gap: 15px;
                padding: 20px;
                background-color: #f9f9f9;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            }

            label {
                font-size: 16px;
                color: #555;
            }

            input[type="text"] {
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 16px;
                transition: border-color 0.3s;
            }

            input[type="text"]:focus {
                border-color: #4CAF50;
                outline: none;
            }

            button {
                padding: 10px 20px;
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
                font-size: 16px;
            }

            button:hover {
                background-color: #45a049;
            }

            /* Table Styles */
            table {
                width: 100%;
                margin-top: 20px;
                border-collapse: collapse;
            }

            table, th, td {
                border: 1px solid #ddd;
            }

            th, td {
                padding: 12px 20px;
                text-align: left;
            }

            th {
                background-color: #f2f2f2;
                color: #333;
            }

            tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            tr:hover {
                background-color: #f1f1f1;
            }

            .btn-action {
                padding: 8px 16px;
                font-size: 14px;
                border-radius: 4px;
                cursor: pointer;
                border: none;
            }

            .btn-edit {
                background-color: #ff9800;
                color: white;
                margin-right: 10px;
            }

            .btn-edit:hover {
                background-color: #f57c00;
            }

            .btn-delete {
                background-color: #f44336;
                color: white;
            }

            .btn-delete:hover {
                background-color: #d32f2f;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .content {
                    grid-template-columns: 1fr;
                }

                form {
                    padding: 15px;
                }

                table {
                    font-size: 14px;
                }
            }
        </style>
    </head>
    <body>
        <main>
            <div class="content">
                <h1>Estudiantes</h1>
            </div>

            <div class="content">
                <form action="">
                    <label for="doc_est">Cédula del estudiante</label>
                    <input type="text" id="doc_est" name="doc_est" required>
                    
                    <label for="nom_est">Nombre del estudiante</label>
                    <input type="text" id="nom_est" name="nom_est" required>
                    
                    <label for="ape_est">Apellido del estudiante</label>
                    <input type="text" id="ape_est" name="ape_est" required>
                    
                    <label for="edad_est">Edad del estudiante</label>
                    <input type="text" id="edad_est" name="edad_est" required>

                    <input type="hidden" name="action" id="action" value="enviar">
                    <button type="submit">Agregar Estudiante</button>
                </form>
                <br>
                <%
                String cedula= request.getParameter("doc_est");
                String nombre= request.getParameter("nom_est");
                String apellido= request.getParameter("ape_est");
                String edad= request.getParameter("edad_est");
                //1String action= request.getParameter("action");
                if ("enviar".equals(request.getParameter("action"))){
                    if( cedula!=null && nombre!=null && apellido!=null && edad!=null){
                    short edadEstudiante= Short.parseShort(edad);
                    EstudianteCRUD crud = new EstudianteCRUD();
                    Estudiante nuevoEstudiante=new Estudiante(cedula, nombre, apellido, edadEstudiante );
                    System.out.println(nuevoEstudiante);
                    crud.crearEstudiante(nuevoEstudiante);
                    }
                                        }
                %>
            </div>

            <div class="content">
                <table>
                    <tr>
                       <th>Cédula</th>
                        <th>Nombre</th>
                        <th>Apellido</th>
                        <th>Edad</th>
                        <th>Editar</th>
                        <th>Borrar</th>
                        
                    </tr>
                    <%
                        EstudianteCRUD estudianteServicio = new EstudianteCRUD();
                        List<Estudiante> listaEstudiantes = estudianteServicio.mostrarEstudiante();
                        if (listaEstudiantes != null) {
                            for (Estudiante infoEstudiante : listaEstudiantes) {
                    %>
                    <tr>
                        <td><%= infoEstudiante.getDoc_est() %></td>
                        <td><%= infoEstudiante.getNom_est() %></td>
                        <td><%= infoEstudiante.getApe_est() %></td>
                        <td><%= infoEstudiante.getEdad_est() %></td>
                        <td>
                            <form method="GET" action="editarEstudiante.jsp">
                                <input type="hidden" name="doc_est" value="<%= infoEstudiante.getDoc_est() %>">
                                <button type="submit" class="btn-action btn-edit">Editar</button>
                            </form>
                        </td>
                        <td>
                            <button type="submit">Borrar</button>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="4">No hay estudiantes registrados</td>
                    </tr>
                    <%
                        }
                    %>
                </table>
            </div>
        </main>
    </body>
</html>
