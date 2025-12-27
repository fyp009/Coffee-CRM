package Admin;

import java.sql.*;

public class admin {
    //fields
    public static String currentAdmin;
    public static String currentAdminRole;

    //constructor
    public admin() {
    }

    //settter
    public static void setCurrentAdmin(String currentAdmin) {
        admin.currentAdmin = currentAdmin;
    }
    public static void setCurrentAdminRole(String currentAdminRole) {
        admin.currentAdminRole = currentAdminRole;
    }

    //getter
    public static String getCurrentAdmin() {
        return currentAdmin;
    }
    public static String getCurrentAdminRole() {
        return currentAdminRole;
    }

    //method set admin online
    public static void ActiveStatus () {
        Database db = new Database();
        Connection connectDb = db.connect();
        String changeStatus = "UPDATE admin_account SET status = 'Active' WHERE admin_username = ?";
        try {
            PreparedStatement statement = connectDb.prepareStatement(changeStatus);
            statement.setString(1, admin.getCurrentAdmin());
            statement.executeUpdate();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //method set admin offline
    public static void OfflineStatus () {
        Database db = new Database();
        Connection connectDb = db.connect();
        String changeStatus = "UPDATE admin_account SET status = 'Offline' WHERE admin_username = ?";
        try {
            PreparedStatement statement = connectDb.prepareStatement(changeStatus);
            statement.setString(1, admin.getCurrentAdmin());
            statement.executeUpdate();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
