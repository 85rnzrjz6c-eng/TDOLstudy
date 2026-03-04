<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="entity.Order" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>我的订单 - 外卖系统</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>

        /*
        在这设置UI页面 下面别动我代码
        记得各个页面的风格一样
        */

        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #dfe9f3 0%, #ffffff 100%);
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Microsoft YaHei", sans-serif;
        }

        .navbar-brand {
            font-weight: 700;
        }

        .order-container {
            max-width: 900px;
            margin: 40px auto;
        }

        .card {
            border-radius: 18px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.07);
            border: none;
        }

        .table thead th {
            background-color: #f8fafc;
        }

        .empty-orders {
            text-align: center;
            padding: 60px 20px;
            color: #777;
        }

        .empty-icon {
            font-size: 48px;
            margin-bottom: 10px;
        }

        .badge-order {
            background: #e8f0fe;
            color: #3b82f6;
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
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="foods">继续点餐</a></li>
                <li class="nav-item"><a class="nav-link" href="cart">购物车</a></li>
                <li class="nav-item"><a class="nav-link active" href="orders">我的订单</a></li>
            </ul>

            <a href="logout" class="btn btn-outline-danger btn-sm">退出登录</a>
        </div>
    </div>
</nav>

<!-- 内容区域 -->
<div class="order-container">
    <div class="card">
        <div class="card-body">

            <h4 class="mb-3">我的订单</h4>
            <p class="text-muted">查看你的历史订单记录</p>

            <%
                List<Order> orders = (List<Order>) request.getAttribute("orders");

                if (orders == null || orders.isEmpty()) {
            %>

            <!-- 没有订单时 -->
            <div class="empty-orders">
                <div class="empty-icon">📭</div>
                <h5 class="mb-2">你还没有订单</h5>
                <p class="mb-3">快去点几样喜欢的菜品吧！</p>
                <a href="foods" class="btn btn-primary btn-sm">去点餐</a>
            </div>

            <%
            } else {
            %>

            <!-- 有订单时 -->
            <div class="table-responsive">
                <table class="table align-middle table-hover">
                    <thead>
                    <tr>
                        <th>订单编号</th>
                        <th>总价（¥）</th>
                        <th>下单时间</th>
                    </tr>
                    </thead>

                    <tbody>
                    <%
                        for (Order o : orders) {
                    %>
                    <tr>
                        <td>
                            <span class="badge rounded-pill badge-order">#<%= o.getId() %></span>
                        </td>
                        <td><strong><%= o.getTotalPrice() %></strong></td>
                        <td><%= o.getCreateTime() %></td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>

                </table>
            </div>

            <%
                }
            %>

        </div>
    </div>
</div>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
