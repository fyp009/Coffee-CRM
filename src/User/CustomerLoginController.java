package User;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;

import java.net.URL;
import java.sql.*;
import java.util.ResourceBundle;

public class CustomerLoginController implements Initializable {

    @FXML
    private AnchorPane loginPane;
    
    @FXML
    private TextField emailField;
    
    @FXML
    private PasswordField passwordField;
    
    @FXML
    private Label errorLabel;
    
    @FXML
    private Button loginBtn;
    
    @FXML
    private Button backBtn;
    
    @FXML
    private Button signupLinkBtn;
    
    private Database database = new Database();
    private Connection connectDb;
    
    public static Customer currentCustomer; // Static field to store logged-in customer

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        connectDb = database.connect();
    }

    @FXML
    private void handleLogin() {
        String email = emailField.getText().trim();
        String password = passwordField.getText();

        // Validation
        if (email.isEmpty() || password.isEmpty()) {
            showError("Please fill in both email and password.");
            return;
        }

        // Authenticate customer
        Customer customer = authenticateCustomer(email, password);
        if (customer != null) {
            currentCustomer = customer; // Store logged-in customer
            showSuccess("Login successful! Welcome, " + customer.getCustomerName() + "!");
            
            // Navigate to user interface after a short delay
            new Thread(() -> {
                try {
                    Thread.sleep(1500); // 1.5 second delay to show success message
                    javafx.application.Platform.runLater(() -> {
                        try {
                            Parent root = FXMLLoader.load(getClass().getResource("UserInterface.fxml"));
                            Stage stage = (Stage) loginPane.getScene().getWindow();
                            Scene scene = new Scene(root);
                            stage.setScene(scene);
                            stage.show();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    });
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }).start();
            
        } else {
            showError("Invalid email or password. Please try again.");
        }
    }

    private Customer authenticateCustomer(String email, String password) {
        try {
            String query = "SELECT * FROM customers WHERE customer_email = ? AND customer_password = ? AND status = 'Active'";
            PreparedStatement statement = connectDb.prepareStatement(query);
            statement.setString(1, email);
            statement.setString(2, password);
            ResultSet result = statement.executeQuery();
            
            if (result.next()) {
                return new Customer(
                    result.getInt("customer_id"),
                    result.getString("customer_name"),
                    result.getString("customer_email"),
                    result.getString("customer_password"),
                    result.getString("created_date"),
                    result.getString("status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private void showError(String message) {
        errorLabel.setText(message);
        errorLabel.setStyle("-fx-text-fill: red;");
        errorLabel.setVisible(true);
    }

    private void showSuccess(String message) {
        errorLabel.setText(message);
        errorLabel.setStyle("-fx-text-fill: green;");
        errorLabel.setVisible(true);
    }

    @FXML
    private void handleBack() {
        try {
            Parent root = FXMLLoader.load(getClass().getResource("DefaultInterface.fxml"));
            Stage stage = (Stage) loginPane.getScene().getWindow();
            Scene scene = new Scene(root);
            stage.setScene(scene);
            stage.show();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @FXML
    private void handleGoToSignup() {
        try {
            Parent root = FXMLLoader.load(getClass().getResource("CustomerSignup.fxml"));
            Stage stage = (Stage) loginPane.getScene().getWindow();
            Scene scene = new Scene(root);
            stage.setScene(scene);
            stage.show();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}