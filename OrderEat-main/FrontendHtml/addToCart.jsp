<%
    String action = request.getParameter("action");
    int itemId = Integer.parseInt(request.getParameter("itemId"));

    if ("add".equals(action)) {
        List<MenuItem> orderItems = (List<MenuItem>) session.getAttribute("orderItems");
        if (orderItems == null) {
            orderItems = new ArrayList();
            session.setAttribute("orderItems", orderItems);
        }
        MenuItem item = menuDAO.getItemById(itemId); // Retrieve the item from the database
        orderItems.add(item); // Add the item to the session's cart
    }
%>