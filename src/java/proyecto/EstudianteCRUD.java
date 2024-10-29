package proyecto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class EstudianteCRUD {

    Conexion sql;
    Connection conexion;
    PreparedStatement declaracion;

    public EstudianteCRUD() {
        this.sql = new Conexion();
    }

    public Estudiante mostrarEstudiante(String idEstudiante) {
        String sentencia = "SELECT * FROM ESTUDIANTE WHERE DOC_EST = ?";
        conexion = sql.conectar();
        try {
            declaracion = conexion.prepareStatement(sentencia);
            declaracion.setString(1, idEstudiante);
            ResultSet resultado = declaracion.executeQuery();
            Estudiante estudiante = null;
            while (resultado.next()) {
                estudiante = new Estudiante(
                        resultado.getString("doc_est"),
                        resultado.getString("nom_est"),
                        resultado.getString("ape_est"),
                        resultado.getShort("edad_est")
                );
            }
            declaracion.close();
            sql.desconectar();
            return estudiante;
        } catch (SQLException ex) {
            Logger.getLogger(EstudianteCRUD.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }

    public Estudiante crearEstudiante(Estudiante estudiante) {
        String consulta = "INSERT INTO ESTUDIANTE(doc_est, nom_est,ape_est, edad_est) VALUES(?,?,?,?)";
        conexion = sql.conectar();
        try {
            declaracion = conexion.prepareStatement(consulta, Statement.RETURN_GENERATED_KEYS);
            declaracion.setString(1, estudiante.getDoc_est());
            declaracion.setString(2, estudiante.getNom_est());
            declaracion.setString(3, estudiante.getApe_est());
            declaracion.setShort(4, estudiante.getEdad_est());
            int filas = declaracion.executeUpdate();
            if (filas > 0) {
                declaracion.close();
                sql.desconectar();
                return mostrarEstudiante(estudiante.getDoc_est());
            }
        } catch (SQLException ex) {
            Logger.getLogger(EstudianteCRUD.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }

    public Estudiante editarEstudiante(Estudiante estudiante, String documento) {
        String consulta = "UPDATE ESTUDIANTE SET "
                + "DOC_EST = ?, NOM_EST = ?, APE_EST = ?, EDAD_EST = ? "
                + "WHERE DOC_EST = ?";
        conexion = sql.conectar();
        try {
            declaracion = conexion.prepareStatement(consulta, Statement.RETURN_GENERATED_KEYS);
            declaracion.setString(1, estudiante.getDoc_est());
            declaracion.setString(2, estudiante.getNom_est());
            declaracion.setString(3, estudiante.getApe_est());
            declaracion.setShort(4, estudiante.getEdad_est());
            declaracion.setString(5, documento);
            int filas = declaracion.executeUpdate();
            if (filas > 0) {
                declaracion.close();
                sql.desconectar();
                return mostrarEstudiante(estudiante.getDoc_est());
            }
        } catch (SQLException ex) {
            Logger.getLogger(EstudianteCRUD.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }

    public boolean borrarEstudiante(String documento) {
        String consulta = "DELETE FROM ESTUDIANTE WHERE DOC_EST = ?";
        conexion = sql.conectar();
        try {
            declaracion = conexion.prepareStatement(consulta);
            declaracion.setString(1, documento);
            declaracion.execute(consulta);
            declaracion.close();
            sql.desconectar();
            return true;

        } catch (SQLException ex) {
            Logger.getLogger(EstudianteCRUD.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;

    }

    public List<Estudiante> mostrarEstudiante() {
        String consulta = "SELECT * FROM ESTUDIANTE";
        conexion = sql.conectar();
        try {
            declaracion = conexion.prepareStatement(consulta);
            ResultSet resultado = declaracion.executeQuery();
            List<Estudiante> estudiantes = new ArrayList<>();
            while (resultado.next()) {
                estudiantes.add(
                        new Estudiante(
                                resultado.getString("doc_est"),
                                resultado.getString("nom_est"),
                                resultado.getString("ape_est"),
                                resultado.getShort("edad_est")
                        )
                );

            }
            sql.desconectar();
            declaracion.close();
            return estudiantes;
          

        } catch (SQLException ex) {
            Logger.getLogger(EstudianteCRUD.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static void main(String[] args) {
        EstudianteCRUD crud = new EstudianteCRUD();
        Estudiante estudiante = crud.mostrarEstudiante("1.098.098.0");
        System.out.println(estudiante.getDoc_est());
        System.out.println(estudiante.getNom_est());
        System.out.println(estudiante.getApe_est());
        System.out.println(estudiante.getEdad_est());

        Estudiante estudianteNuevo = new Estudiante("2.750.552", "cat", "bon", (short) 31);
        Estudiante nuevo = crud.crearEstudiante(estudianteNuevo);
        System.out.println(nuevo.getDoc_est());
        System.out.println(nuevo.getNom_est());
        System.out.println(nuevo.getApe_est());
        System.out.println(nuevo.getEdad_est());

    }
}
