package servlet;

import dao.FoodDao;
import entity.CartItem;
import entity.Food;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

@WebServlet("/cart/add")
public class AddToCartServlet extends HttpServlet {

    private final FoodDao foodDao = new FoodDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        int foodId = Integer.parseInt(req.getParameter("foodId"));
        Food food = foodDao.findById(foodId);
        if (food == null) {
            resp.sendRedirect("../foods");
            return;
        }

        HttpSession session = req.getSession();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new LinkedHashMap<>();
            session.setAttribute("cart", cart);
        }

        CartItem item = cart.get(foodId);
        if (item == null) {
            cart.put(foodId, new CartItem(food, 1));
        } else {
            item.setQuantity(item.getQuantity() + 1);
        }

        resp.sendRedirect("../cart");
    }
}
