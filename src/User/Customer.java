package User;

public class Customer {
    private int customerId;
    private String customerName;
    private String customerEmail;
    private String customerPassword;
    private String createdDate;
    private String status;

    // Default constructor
    public Customer() {
    }

    // Constructor with all fields
    public Customer(int customerId, String customerName, String customerEmail, String customerPassword, String createdDate, String status) {
        this.customerId = customerId;
        this.customerName = customerName;
        this.customerEmail = customerEmail;
        this.customerPassword = customerPassword;
        this.createdDate = createdDate;
        this.status = status;
    }

    // Constructor for new customer registration
    public Customer(String customerName, String customerEmail, String customerPassword) {
        this.customerName = customerName;
        this.customerEmail = customerEmail;
        this.customerPassword = customerPassword;
        this.status = "Active";
    }

    // Getters and Setters
    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public String getCustomerPassword() {
        return customerPassword;
    }

    public void setCustomerPassword(String customerPassword) {
        this.customerPassword = customerPassword;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}