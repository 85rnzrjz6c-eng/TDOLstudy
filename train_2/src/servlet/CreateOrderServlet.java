package servlet;

import dao.OrderDao;
import dao.OrderItemDao;
import entity.CartItem;
import entity.OrderItem;
import entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.*;

@WebServlet("/order/create")
public class CreateOrderServlet extends HttpServlet {

    private final OrderDao orderDao = new OrderDao();
    private final OrderItemDao orderItemDao = new OrderItemDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");
        if (user == null) {
            resp.sendRedirect("../login.jsp");
            return;
        }

        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect("../cart");
            return;
        }

        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : cart.values()) {
            total = total.add(item.getTotalPrice());
        }

        int orderId = orderDao.insert(user.getId(), total);
        if (orderId <= 0) {
            req.setAttribute("msg", "下单失败");
            req.getRequestDispatcher("/cart.jsp").forward(req, resp);
            return;
        }

        List<OrderItem> items = new ArrayList<>();
        for (CartItem cartItem : cart.values()) {
            OrderItem oi = new OrderItem();
            oi.setOrderId(orderId);
            oi.setFoodId(cartItem.getFood().getId());
            oi.setQuantity(cartItem.getQuantity());
            oi.setPrice(cartItem.getFood().getPrice());
            items.add(oi);
        }
        orderItemDao.batchInsert(items);

        session.removeAttribute("cart");

        resp.sendRedirect("../orders");
    }
}
