package omadikh;

public class Admin {
    private int adminId;
    private String name;
    private String email;
    private String password;
    private AdminRoleEnum role;

    public enum AdminRoleEnum {
        OWNER,
        WAITER,
    }

    // Constructor
    public Admin(int adminId, String name, String email, String password, AdminRoleEnum role) {
        this.adminId = adminId;
        this.name = name;
        this.email = email;
        this.password = password;
        this.role = role;
    }
    // Constructor
    public Admin(int adminId, String name, String email, String password) {
        this.adminId = adminId;
        this.name = name;
        this.email = email;
        this.password = password;
        this.role = AdminRoleEnum.OWNER;
    }

    public Admin() {
    }

    // Getters and Setters
    public int getAdminId() {
        return adminId;
    }

    public void setAdminId(int adminId) {
        this.adminId = adminId;
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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public AdminRoleEnum getRole() {
        return role;
    }

    public void setRole(AdminRoleEnum role) {
        this.role = role;
    }

    // toString Method
    @Override
    public String toString() {
        return "Admin{" +
                "adminId=" + adminId +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", role=" + role +
                '}';
    }
}