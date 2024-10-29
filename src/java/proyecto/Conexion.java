
package proyecto;


import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Connection;

public class Conexion {
    String db = "cat"; // Nombre de la base de datos
    String url = "jdbc:mysql://localhost:3306/";
    String user = "root";
    String password = "";
    String driver = "com.mysql.cj.jdbc.Driver"; // MySQL Connector/J driver
    Connection conexion;
    
   
    public Connection conectar() {
        try {
            Class.forName(driver);
            conexion = DriverManager.getConnection(url + db, user, password);
            System.out.println("Se conectó a la base de datos");

        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println("No se conectó a la base de datos");
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
        } 
        return conexion;
    }
     
    public void desconectar() {
        try {
            if (conexion != null && !conexion.isClosed()) {
                conexion.close();
                System.out.println("desconexion de la base detos");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void main(String[] args) {
        Conexion conexion = new Conexion();
        conexion.conectar();
    }
}
