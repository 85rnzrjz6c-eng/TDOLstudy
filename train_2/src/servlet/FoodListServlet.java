package servlet;

import dao.FoodDao;
import entity.Food;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/foods")
public class FoodListServlet extends HttpServlet {

    private final FoodDao foodDao = new FoodDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Food> list = foodDao.findAll();
        req.setAttribute("foods", list);
        req.getRequestDispatcher("/food_list.jsp").forward(req, resp);
    }
}
