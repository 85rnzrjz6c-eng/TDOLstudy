<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="entity.Food" %>
<%@ page import="entity.User" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>菜品列表 - 外卖系统</title>

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>

        /*
        在这设置UI页面 下面别动我代码
        记得各个页面的风格一样
        */

        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #fdfbfb 0%, #ebedee 100%);
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Microsoft YaHei", sans-serif;
        }

        .navbar-brand {
            font-weight: 700;
        }

        .page-header {
            padding: 24px 0 8px;
        }

        .page-header h3 {
            font-weight: 700;
        }

        .food-grid {
            padding-bottom: 40px;
        }

        .food-card {
            border-radius: 18px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.06);
            transition: transform .15s ease, box-shadow .15s ease;
            border: none;
        }

        .food-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 14px 30px rgba(0,0,0,0.10);
        }

        .food-name {
            font-size: 18px;
            font-weight: 600;
        }

        .food-price {
            font-size: 18px;
            font-weight: 700;
            color: #ff7a1a;
        }

        .food-desc {
            font-size: 14px;
            color: #777;
            min-height: 40px;
        }

        .btn-add-cart {
            border-radius: 999px;
            font-size: 14px;
            padding: 6px 16px;
            font-weight: 500;
        }

        .badge-id {
            font-size: 11px;
            background-color: #e9f2ff;
            color: #3b82f6;
        }

        .empty-list {
            text-align: center;
            padding: 60px 20px;
            color: #888;
        }
    </style>
</head>
<body>

<%
    User user = (User) session.getAttribute("currentUser");
%>

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
                    <a class="nav-link active" href="foods">菜品列表</a>
                </li>
                <%
                    if (user != null) {
                %>
                <li class="nav-item">
                    <a class="nav-link" href="cart">购物车</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="orders">我的订单</a>
                </li>
                <%
                    }
                %>
            </ul>

            <div class="d-flex align-items-center">
                <%
                    if (user == null) {
                %>
                <a href="login.jsp" class="btn btn-outline-primary btn-sm me-2">登录</a>
                <a href="register" class="btn btn-primary btn-sm">注册</a>
                <%
                } else {
                %>
                <span class="me-3 text-muted">
                    欢迎你，<strong><%= user.getUsername() %></strong>
                </span>
                <a href="logout" class="btn btn-outline-danger btn-sm">退出登录</a>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</nav>

<div class="container">

    <!-- 标题区域 -->
    <div class="page-header d-flex justify-content-between align-items-center">
        <div>
            <h3>菜品列表</h3>
            <p class="text-muted mb-0">精心为你准备的美味，点击加入购物车即可下单</p>
        </div>
    </div>

    <div class="food-grid">
        <div class="row g-4">
            <%
                List<Food> foods = (List<Food>) request.getAttribute("foods");
                if (foods == null || foods.isEmpty()) {
            %>
            <div class="col-12">
                <div class="empty-list">
                    <h5>暂时没有菜品</h5>
                    <p>请稍后再试，或联系管理员添加菜品</p>
                </div>
            </div>
            <%
            } else {
                for (Food f : foods) {
            %>
            <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                <div class="card food-card h-100">
                    <div class="card-body d-flex flex-column">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="food-name"><%= f.getName() %></span>
                            <span class="badge rounded-pill badge-id">编号 <%= f.getId() %></span>
                        </div>
                        <div class="food-desc mb-2">
                            <%= f.getDescription() == null ? "暂无描述" : f.getDescription() %>
                        </div>
                        <div class="d-flex justify-content-between align-items-center mt-auto">
                            <div class="food-price">¥ <%= f.getPrice() %></div>
                            <form action="cart/add" method="post" class="mb-0">
                                <input type="hidden" name="foodId" value="<%= f.getId() %>">
                                <button type="submit" class="btn btn-sm btn-warning btn-add-cart">
                                    加入购物车
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <%
                    }
                }
            %>
        </div>
    </div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
