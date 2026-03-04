<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Map" %>
<%@ page import="entity.CartItem" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>购物车 - 外卖系统</title>

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        /*
        在这设置UI页面 下面别动我代码
        记得各个页面的风格一样
        */
        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Microsoft YaHei", sans-serif;
        }

        .navbar-brand {
            font-weight: 700;
        }

        .cart-container {
            max-width: 960px;
            margin: 40px auto;
        }

        .card {
            border-radius: 18px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
        }

        .table thead th {
            background: #fff7f0;
            border-bottom-width: 1px;
        }

        .total-row td {
            font-weight: 600;
            font-size: 16px;
            border-top: 2px solid #f0f0f0;
        }

        .btn-submit-order {
            border-radius: 999px;
            padding: 10px 26px;
            font-weight: 600;
        }

        .empty-cart {
            padding: 40px 20px;
            text-align: center;
            color: #777;
        }

        .empty-cart-icon {
            font-size: 48px;
            margin-bottom: 10px;
        }

        /* 新增：删除按钮样式 */
        .btn-remove-one {
            border-radius: 999px;
            padding: 4px 12px;
            font-size: 13px;
        }
    </style>
</head>
<body>

<!-- 顶部导航 -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="foods">外卖点餐系统</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navMenu">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="foods">继续点餐</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="cart">购物车</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="orders">我的订单</a>
                </li>
            </ul>
            <a href="logout" class="btn btn-outline-danger btn-sm">退出登录</a>
        </div>
    </div>
</nav>

<div class="cart-container">
    <div class="card">
        <div class="card-body">
            <h4 class="card-title mb-3">购物车</h4>
            <p class="text-muted mb-4">确认你的菜品，可以减少数量或提交订单～</p>

            <%
                Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
                if (cart == null || cart.isEmpty()) {
            %>

            <!-- 购物车为空时 -->
            <div class="empty-cart">
                <div class="empty-cart-icon">🛒</div>
                <h5 class="mb-2">购物车还是空的</h5>
                <p class="mb-3">去挑几道喜欢的菜品吧</p>
                <a href="foods" class="btn btn-primary btn-sm">去点餐</a>
            </div>

            <%
            } else {
            %>

            <!-- 购物车列表 -->
            <div class="table-responsive">
                <table class="table align-middle">
                    <thead>
                    <tr>
                        <th scope="col">菜品名称</th>
                        <th scope="col">单价</th>
                        <th scope="col">数量</th>
                        <th scope="col">小计</th>
                        <th scope="col">操作</th> <!-- 新增操作列 -->
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        for (CartItem item : cart.values()) {
                    %>
                    <tr>
                        <td><%= item.getFood().getName() %></td>
                        <td>¥ <%= item.getFood().getPrice() %></td>
                        <td><%= item.getQuantity() %></td>
                        <td>¥ <%= item.getTotalPrice() %></td>
                        <td>
                            <!-- 新增：删除一个按钮 -->
                            <form action="cart/remove" method="post" class="mb-0">
                                <input type="hidden" name="foodId" value="<%= item.getFood().getId() %>">
                                <button type="submit" class="btn btn-outline-danger btn-remove-one">
                                    - 减少一个
                                </button>
                            </form>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                    <tr class="total-row">
                        <td colspan="3" class="text-end">总价</td>
                        <td colspan="2">¥ <strong><%= request.getAttribute("total") %></strong></td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <!-- 提交订单 -->
            <div class="d-flex justify-content-between align-items-center mt-3">
                <a href="foods" class="btn btn-outline-secondary btn-sm">继续点餐</a>
                <form action="order/create" method="post" class="mb-0">
                    <button type="submit" class="btn btn-success btn-submit-order">
                        提交订单
                    </button>
                </form>
            </div>

            <%
                }
            %>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
