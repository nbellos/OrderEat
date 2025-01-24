package omadikh;
import java.util.List;
import java.util.ArrayList;

public class Menu {
    
    private int menuId;
    private ArrayList<MenuItem> items;

    // Constructor
    public Menu(int menuId, List<MenuItem> items) {
        this.menuId = menuId;
        this.items = new ArrayList<>(items);
    }

    // Getter and Setter for menuId
    public int getMenuId() {
        return menuId;
    }

    public void setMenuId(int menuId) {
        this.menuId = menuId;
    }

    // Getter for items
    public List<MenuItem> getItems() {
        return items;
    }

    // Method to add an item to the menu
    public void addItem(MenuItem item) {
        items.add(item);
    }

    // Method to remove an item from the menu
    public void removeItem(MenuItem item) {
        items.remove(item);
    }
}
