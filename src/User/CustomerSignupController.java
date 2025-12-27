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

public class CustomerSignupController implements Initializable {

    @FXML
    private AnchorPane signupPane;
    
    @FXML
    private TextField nameField;
    
    @FXML
    private TextField emailField;
    
    @FXML
    private PasswordField passwordField;
    
    @FXML
    private PasswordField confirmPasswordField;
    
    @FXML
    private Label errorLabel;
    
    @FXML
    private Button signupBtn;
    
    @FXML
    private Button backBtn;
    
    @FXML
    private Button loginLinkBtn;
    
    private Database database = new Database();
    private Connection connectDb;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        connectDb = database.connect();
    }

    @FXML
    private void handleSignUp() {
        String name = nameField.getText().trim();
        String email = emailField.getText().trim();
        String password = passwordField.getText();
        String confirmPassword = confirmPasswordField.getText();

        // Validation
        if (name.isEmpty() || email.isEmpty() || password.isEmpty() || confirmPassword.isEmpty()) {
            showError("Please fill in all fields.");
            return;
        }

        if (!email.contains("@") || !email.contains(".")) {
            showError("Please enter a valid email address.");
            return;
        }

        if (password.length() < 6) {
            showError("Password must be at least 6 characters long.");
            return;
        }

        if (!password.equals(confirmPassword)) {
            showError("Passwords do not match.");
            return;
        }

        // Check if email already exists
        if (isEmailExists(email)) {
            showError("An account with this email already exists.");
            return;
        }

        // Register customer
        if (registerCustomer(name, email, password)) {
            showSuccess("Account created successfully! You can now login.");
            clearFields();
        } else {
            showError("Registration failed. Please try again.");
        }
    }

    private boolean isEmailExists(String email) {
        try {
            String query = "SELECT customer_email FROM customers WHERE customer_email = ?";
            PreparedStatement statement = connectDb.prepareStatement(query);
            statement.setString(1, email);
            ResultSet result = statement.executeQuery();
            return result.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return true; // Assume exists to prevent duplicate registration on error
        }
    }

    private boolean registerCustomer(String name, String email, String password) {
        try {
            String query = "INSERT INTO customers (customer_name, customer_email, customer_password) VALUES (?, ?, ?)";
            PreparedStatement statement = connectDb.prepareStatement(query);
            statement.setString(1, name);
            statement.setString(2, email);
            statement.setString(3, password);
            
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
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

    private void clearFields() {
        nameField.clear();
        emailField.clear();
        passwordField.clear();
        confirmPasswordField.clear();
    }

    @FXML
    private void handleBack() {
        try {
            Parent root = FXMLLoader.load(getClass().getResource("DefaultInterface.fxml"));
            Stage stage = (Stage) signupPane.getScene().getWindow();
            Scene scene = new Scene(root);
            stage.setScene(scene);
            stage.show();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @FXML
    private void handleGoToLogin() {
        try {
            Parent root = FXMLLoader.load(getClass().getResource("CustomerLogin.fxml"));
            Stage stage = (Stage) signupPane.getScene().getWindow();
            Scene scene = new Scene(root);
            stage.setScene(scene);
            stage.show();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}