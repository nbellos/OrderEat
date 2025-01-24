package omadikh;

public class Customer {

    // Attributes
    private String customerId;
    private String password;
    private String name;
    private String email;
    private String phone;
    private String loyaltyPoints;

    // Constructor
    public Customer(String customerId, String password, String name, String email, String phone, String loyaltyPoints) {
        this.customerId = customerId;
        this.password = password;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.loyaltyPoints = loyaltyPoints;
    }

    // Getters and Setters
    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getLoyaltyPoints() {
        return loyaltyPoints;
    }

    public void setLoyaltyPoints(String loyaltyPoints) {
        this.loyaltyPoints = loyaltyPoints;
    }

    // toString method for displaying Customer details
    @Override
    public String toString() {
        return "Customer {" +
                "customerId='" + customerId + '\'' +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", loyaltyPoints='" + loyaltyPoints + '\'' +
                '}';
    }
}