package User;
import java.sql.*;
import java.io.File;

public class Database {
    Connection linkDatabase;
    String databasePath = "coffeeshop.db";
    String URL = "jdbc:sqlite:" + databasePath; 

    public Database(){}

    public Connection connect(){
        try {
            // Load SQLite JDBC driver
            Class.forName("org.sqlite.JDBC");
            
            // Create database file if it doesn't exist
            File dbFile = new File(databasePath);
            boolean isNewDatabase = !dbFile.exists();
            
            // Configure SQLite connection properties for better concurrency
            String urlWithParams = URL + "?journal_mode=WAL&synchronous=NORMAL";
            linkDatabase = DriverManager.getConnection(urlWithParams);
            
            // If this is a new database, initialize it with the schema
            if (isNewDatabase) {
                initializeDatabase();
            }
            
        } catch (Exception e) {
            System.out.println("Failed to connect to the database!");
            e.printStackTrace();
        }
        
        return linkDatabase;
    }
    
    private void initializeDatabase() {
        try {
            Statement stmt = linkDatabase.createStatement();
            
            // Read and execute the SQLite schema
            String[] sqlCommands = getSQLiteSchema();
            for (String sql : sqlCommands) {
                if (!sql.trim().isEmpty()) {
                    stmt.executeUpdate(sql);
                }
            }
            
            System.out.println("Database initialized successfully!");
        } catch (SQLException e) {
            System.out.println("Failed to initialize database!");
            e.printStackTrace();
        }
    }
    
    private String[] getSQLiteSchema() {
        // Simplified schema initialization - you can expand this
        return new String[]{
            "CREATE TABLE IF NOT EXISTS admin_account (admin_username TEXT PRIMARY KEY NOT NULL, admin_password TEXT NOT NULL DEFAULT 'password', role TEXT NOT NULL, status TEXT NOT NULL DEFAULT 'Offline')",
            "INSERT OR IGNORE INTO admin_account (admin_username, admin_password, role, status) VALUES ('Admin', '123', 'Admin', 'Offline')",
            "INSERT OR IGNORE INTO admin_account (admin_username, admin_password, role, status) VALUES ('Sothirich', '123', 'Cashier', 'Offline')",
            
            "CREATE TABLE IF NOT EXISTS drink_list (drink_id INTEGER PRIMARY KEY AUTOINCREMENT, drink_name TEXT NOT NULL, drink_hot_price REAL NOT NULL, drink_iced_price REAL NOT NULL, drink_frappee_price REAL NOT NULL, drink_img TEXT NOT NULL DEFAULT 'resources/img/temp_icon.png')",
            "INSERT OR IGNORE INTO drink_list (drink_id, drink_name, drink_hot_price, drink_iced_price, drink_frappee_price, drink_img) VALUES (1, 'Latte', 1.25, 2.80, 3.15, 'resources/img/Latte.png')",
            "INSERT OR IGNORE INTO drink_list (drink_id, drink_name, drink_hot_price, drink_iced_price, drink_frappee_price, drink_img) VALUES (2, 'Cappucino', 1.25, 2.50, 2.75, 'resources/img/Cappuccino.png')",
            "INSERT OR IGNORE INTO drink_list (drink_id, drink_name, drink_hot_price, drink_iced_price, drink_frappee_price, drink_img) VALUES (3, 'Americano', 1.30, 2.25, 3.25, 'resources/img/Americano.png')",
            "INSERT OR IGNORE INTO drink_list (drink_id, drink_name, drink_hot_price, drink_iced_price, drink_frappee_price, drink_img) VALUES (4, 'Caramel Macchiato', 1.25, 2.80, 3.75, 'resources/img/Macchiato.png')",
            "INSERT OR IGNORE INTO drink_list (drink_id, drink_name, drink_hot_price, drink_iced_price, drink_frappee_price, drink_img) VALUES (5, 'Condensed Milk', 1.00, 2.50, 2.80, 'resources/img/Milk.png')",
            "INSERT OR IGNORE INTO drink_list (drink_id, drink_name, drink_hot_price, drink_iced_price, drink_frappee_price, drink_img) VALUES (6, 'Mocha', 1.25, 2.15, 2.65, 'resources/img/Mocha.png')",
            
            "CREATE TABLE IF NOT EXISTS customers (customer_id INTEGER PRIMARY KEY AUTOINCREMENT, customer_name TEXT NOT NULL, customer_email TEXT UNIQUE NOT NULL, customer_password TEXT NOT NULL, created_date DATE NOT NULL DEFAULT (DATE('now')), status TEXT NOT NULL DEFAULT 'Active')",
            "INSERT OR IGNORE INTO customers (customer_name, customer_email, customer_password) VALUES ('John Doe', 'john@example.com', 'password123')",
            "INSERT OR IGNORE INTO customers (customer_name, customer_email, customer_password) VALUES ('Jane Smith', 'jane@example.com', 'password123')",
            
            "CREATE TABLE IF NOT EXISTS feedback (feedback_id INTEGER PRIMARY KEY AUTOINCREMENT, customer_id INTEGER NOT NULL, order_id INTEGER, rating INTEGER NOT NULL CHECK(rating >= 1 AND rating <= 5), comment TEXT, feedback_date DATE NOT NULL DEFAULT (DATE('now')), feedback_time TIME NOT NULL DEFAULT (TIME('now')))",
            
            "CREATE TABLE IF NOT EXISTS history (Nº INTEGER PRIMARY KEY AUTOINCREMENT, customer_id INTEGER NOT NULL, drink_name TEXT NOT NULL, drink_type TEXT NOT NULL, drink_price REAL NOT NULL, drink_quantity INTEGER NOT NULL, total_price REAL NOT NULL, date DATE NOT NULL DEFAULT (DATE('now')), time TIME NOT NULL DEFAULT (TIME('now')), status TEXT NOT NULL DEFAULT 'Ordered', confirmed_by TEXT, accepted_by TEXT)",
            
            "CREATE TABLE IF NOT EXISTS temp_admin (Nº INTEGER PRIMARY KEY AUTOINCREMENT, admin_username TEXT NOT NULL, admin_password TEXT NOT NULL DEFAULT 'password', role TEXT NOT NULL, status TEXT NOT NULL DEFAULT 'Offline')",
            "INSERT OR IGNORE INTO temp_admin (admin_username, admin_password, role, status) VALUES ('Admin', '123', 'Admin', 'Active')",
            
            "CREATE TABLE IF NOT EXISTS temp_customer (Nº INTEGER PRIMARY KEY AUTOINCREMENT, customer_id INTEGER NOT NULL, drink_name TEXT NOT NULL, drink_type TEXT NOT NULL, drink_price REAL NOT NULL, drink_quantity INTEGER NOT NULL, total_price REAL NOT NULL)",
            
            "CREATE TABLE IF NOT EXISTS temp_drinklist (drink_id INTEGER PRIMARY KEY AUTOINCREMENT, drink_name TEXT NOT NULL, drink_hot_price REAL NOT NULL, drink_iced_price REAL NOT NULL, drink_frappee_price REAL NOT NULL, drink_img TEXT NOT NULL DEFAULT 'resources/img/temp_icon.png')",
            "INSERT OR IGNORE INTO temp_drinklist (drink_id, drink_name, drink_hot_price, drink_iced_price, drink_frappee_price, drink_img) VALUES (1, 'Latte', 1.25, 2.80, 3.15, 'resources/img/Latte.png')",
            "INSERT OR IGNORE INTO temp_drinklist (drink_id, drink_name, drink_hot_price, drink_iced_price, drink_frappee_price, drink_img) VALUES (2, 'Cappucino', 1.25, 2.50, 2.75, 'resources/img/Cappuccino.png')",
            "INSERT OR IGNORE INTO temp_drinklist (drink_id, drink_name, drink_hot_price, drink_iced_price, drink_frappee_price, drink_img) VALUES (3, 'Americano', 1.30, 2.25, 3.25, 'resources/img/Americano.png')",
            "INSERT OR IGNORE INTO temp_drinklist (drink_id, drink_name, drink_hot_price, drink_iced_price, drink_frappee_price, drink_img) VALUES (4, 'Caramel Macchiato', 1.25, 2.80, 3.75, 'resources/img/Macchiato.png')",
            "INSERT OR IGNORE INTO temp_drinklist (drink_id, drink_name, drink_hot_price, drink_iced_price, drink_frappee_price, drink_img) VALUES (5, 'Condensed Milk', 1.00, 2.50, 2.80, 'resources/img/Milk.png')",
            "INSERT OR IGNORE INTO temp_drinklist (drink_id, drink_name, drink_hot_price, drink_iced_price, drink_frappee_price, drink_img) VALUES (6, 'Mocha', 1.25, 2.15, 2.65, 'resources/img/Mocha.png')"
        };
    }
}   
