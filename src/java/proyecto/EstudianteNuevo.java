
package proyecto;

public class EstudianteNuevo {
   
   private String nom_est;
   private String ape_est;
   private Short edad_est;

    public EstudianteNuevo (String nom_est, String ape_est, Short edad_est) {
        
        this.nom_est = nom_est;
        this.ape_est = ape_est;
        this.edad_est = edad_est;
    }

    public String getNom_est() {
        return nom_est;
    }

    public void setNom_est(String nom_est) {
        this.nom_est = nom_est;
    }

    public String getApe_est() {
        return ape_est;
    }

    public void setApe_est(String ape_est) {
        this.ape_est = ape_est;
    }

    public Short getEdad_est() {
        return edad_est;
    }

    public void setEdad_est(Short edad_est) {
        this.edad_est = edad_est;
    }
    
}
