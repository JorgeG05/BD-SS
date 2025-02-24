package com.mycompany.trabajo_predic;

import java.sql.Connection;
import java.sql.DriverManager;
import javax.swing.JOptionPane;

public class CConexion {
    
    // Atributos de conexión
    private Connection conectar = null;
    
    // Parámetros de conexión
    private String usuario = "usersql";
    private String contrasenia = "123456";
    private String bd = "PrediccionSalud";
    private String ip = "localhost";
    private String puerto = "1433";
    
    // Cadena de conexión
    private String cadena = "jdbc:sqlserver://" + ip + ":" + puerto + ";" + "databaseName=" + bd;

    // Método para establecer la conexión
    public Connection establecerConexion() {
        try {
            // Usar la cadena de conexión definida a nivel de clase
            conectar = DriverManager.getConnection(cadena, usuario, contrasenia);
            JOptionPane.showMessageDialog(null, "Se conectó correctamente a la Base de Datos");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Error al conectar a la base de datos, error: " + e.toString());
        }
        return conectar;
    }  

    void establecerconexion() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
