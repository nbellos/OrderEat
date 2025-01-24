package omadikh;

public class MenuItem {
    private int itemId;
    private String name;
    private String description;
    private float price;
    private String category;
    public int quantity;

    // Constructor to initialize all fields
    public MenuItem(int itemId, String name, String description, float price, String category) {
        this.itemId = itemId;
        this.name = name;
        this.description = description;
        this.price = price;
        this.category = category;
        this.quantity = 0;
    }

    // Default constructor (useful for frameworks)
    public MenuItem() {}

    // Getter and Setter for itemId
    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    // Getter and Setter for name
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    // Getter and Setter for description
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    // Getter and Setter for price
    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    // Getter and Setter for category
    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getQuantity(){
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }


    // Override toString for better object representation
    @Override
    public String toString() {
        return "MenuItem [itemId=" + itemId + ", name=" + name + ", description=" + description +
               ", price=" + price + ", category=" + category + "]";
    }
}
