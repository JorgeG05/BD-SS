package com.mycompany.trabajo_predic;

import java.sql.*;

public class HealthMonitor {
    public static void main(String[] args) {
        String url = "jdbc:sqlserver://localhost:1433;databaseName=PrediccionSalud;integratedSecurity=true;";
        String user = "sa";  // Cambiar según configuración
        String password = "password"; // Cambiar según configuración

        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            System.out.println("Conectado a la base de datos.");
            String query = "SELECT id_paciente, frecuencia_cardiaca, presion_sanguinea, temperatura_corporal, nivel_glucosa FROM tblDatos_Biometricos";
            
            try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
                while (rs.next()) {
                    int idPaciente = rs.getInt("id_paciente");
                    double frecuenciaCardiaca = rs.getDouble("frecuencia_cardiaca");
                    String presionSanguinea = rs.getString("presion_sanguinea");
                    double temperatura = rs.getDouble("temperatura_corporal");
                    double nivelGlucosa = rs.getDouble("nivel_glucosa");
                    
                    if (esDañino(frecuenciaCardiaca, presionSanguinea, temperatura, nivelGlucosa)) {
                        System.out.println("ALERTA: Valores dañinos detectados para el paciente ID " + idPaciente);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public static boolean esDañino(double frecuencia, String presion, double temperatura, double glucosa) {
        String[] presionValores = presion.split("/");
        int sistolica = Integer.parseInt(presionValores[0]);
        int diastolica = Integer.parseInt(presionValores[1]);
        
        return (frecuencia < 50 || frecuencia > 100) || // Rango normal: 50-100 BPM
               (sistolica < 90 || sistolica > 140 || diastolica < 60 || diastolica > 90) || // Presión normal: 90/60 - 140/90
               (temperatura < 35.0 || temperatura > 38.0) || // Temperatura normal: 36-37.5°C
               (glucosa > 140); // Nivel de glucosa elevado (hiperglucemia)
    }
}
