package servlet;

import entity.CartItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

@WebServlet("/cart/remove")
public class DeleteFromServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        if (cart != null) {
            String foodIdStr = req.getParameter("foodId");
            try {
                int foodId = Integer.parseInt(foodIdStr);
                CartItem item = cart.get(foodId);
                if (item != null) {
                    int qty = item.getQuantity();
                    if (qty > 1) {
                        // 只减少一个数量
                        item.setQuantity(qty - 1);
                    } else {
                        // 只剩 1 个时，直接把这个菜从购物车中移除
                        cart.remove(foodId);
                    }
                }
            } catch (NumberFormatException ignored) {
            }
        }

        // 操作完回到购物车页面
        resp.sendRedirect("../cart");
    }
}
