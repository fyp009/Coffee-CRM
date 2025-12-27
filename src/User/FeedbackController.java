package User;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.image.ImageView;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;

import java.net.URL;
import java.sql.*;
import java.util.ResourceBundle;

public class FeedbackController implements Initializable {

    @FXML
    private AnchorPane feedbackPane;
    
    @FXML
    private ImageView starImage;
    
    @FXML
    private Button star1, star2, star3, star4, star5;
    
    @FXML
    private Label ratingLabel;
    
    @FXML
    private TextArea commentArea;
    
    @FXML
    private Button submitBtn, skipBtn;
    
    private int currentRating = 0;
    private Database database = new Database();
    private Connection connectDb;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        connectDb = database.connect();
        updateStarDisplay();
    }

    @FXML
    private void handleStar1() {
        setRating(1);
    }

    @FXML
    private void handleStar2() {
        setRating(2);
    }

    @FXML
    private void handleStar3() {
        setRating(3);
    }

    @FXML
    private void handleStar4() {
        setRating(4);
    }

    @FXML
    private void handleStar5() {
        setRating(5);
    }

    private void setRating(int rating) {
        currentRating = rating;
        updateStarDisplay();
        ratingLabel.setText("Rating: " + rating + "/5");
    }

    private void updateStarDisplay() {
        Button[] stars = {star1, star2, star3, star4, star5};
        
        for (int i = 0; i < stars.length; i++) {
            if (i < currentRating) {
                // Filled star (selected)
                stars[i].setStyle("-fx-background-color: #FFD700; -fx-text-fill: #8B4513; -fx-border-color: #8B4513; -fx-border-radius: 25; -fx-background-radius: 25;");
            } else {
                // Empty star (not selected)
                stars[i].setStyle("-fx-background-color: #f0f0f0; -fx-text-fill: #ccc; -fx-border-color: #ccc; -fx-border-radius: 25; -fx-background-radius: 25;");
            }
        }
    }

    @FXML
    private void handleSubmitFeedback() {
        if (currentRating == 0) {
            showAlert("Please Rate", "Please select a rating before submitting feedback.");
            return;
        }

        boolean success = saveFeedback();
        if (success) {
            showAlert("Thank You!", "Your feedback has been submitted successfully!");
            goToMainMenu();
        } else {
            showAlert("Error", "Failed to submit feedback. Please try again.");
        }
    }

    @FXML
    private void handleSkipFeedback() {
        goToMainMenu();
    }

    private boolean saveFeedback() {
        try {
            String comment = commentArea.getText().trim();
            if (comment.isEmpty()) {
                comment = null; // Optional comment
            }

            // Get customer ID if logged in, otherwise use a default value
            int customerId = 0;
            if (CustomerLoginController.currentCustomer != null) {
                customerId = CustomerLoginController.currentCustomer.getCustomerId();
            }

            String query = "INSERT INTO feedback (customer_id, rating, comment) VALUES (?, ?, ?)";
            PreparedStatement statement = connectDb.prepareStatement(query);
            statement.setInt(1, customerId);
            statement.setInt(2, currentRating);
            statement.setString(3, comment);

            int rowsAffected = statement.executeUpdate();
            statement.close();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private void showAlert(String title, String message) {
        Alert alert = new Alert(Alert.AlertType.INFORMATION);
        alert.setTitle(title);
        alert.setHeaderText(null);
        alert.setContentText(message);
        alert.showAndWait();
    }

    private void goToMainMenu() {
        try {
            // Clear current customer session if it exists
            CustomerLoginController.currentCustomer = null;
            
            Parent root = FXMLLoader.load(getClass().getResource("../DefaultInterface.fxml"));
            Stage stage = (Stage) feedbackPane.getScene().getWindow();
            Scene scene = new Scene(root);
            stage.setScene(scene);
            stage.setFullScreen(false);
            stage.setResizable(false);
            stage.centerOnScreen();
            stage.show();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}