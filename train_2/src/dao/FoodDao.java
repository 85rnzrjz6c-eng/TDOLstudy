package dao;

import entity.Food;
import util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class FoodDao {

    public List<Food> findAll() {
        List<Food> list = new ArrayList<>();
        String sql = "SELECT * FROM t_food";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Food f = new Food();
                f.setId(rs.getInt("id"));
                f.setName(rs.getString("name"));
                f.setPrice(rs.getBigDecimal("price"));
                f.setDescription(rs.getString("description"));
                list.add(f);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Food findById(int id) {
        String sql = "SELECT * FROM t_food WHERE id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Food f = new Food();
                f.setId(rs.getInt("id"));
                f.setName(rs.getString("name"));
                f.setPrice(rs.getBigDecimal("price"));
                f.setDescription(rs.getString("description"));
                return f;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
