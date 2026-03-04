<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>登录 - 外卖系统</title>

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>

        /*
        在这设置UI页面 下面别动我代码
        记得各个页面的风格一样
        */

        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #ff9a9e 0%, #fad0c4 50%, #fbc2eb 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Microsoft YaHei", sans-serif;
        }

        .login-card {
            width: 100%;
            max-width: 420px;
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.12);
            padding: 32px 32px 28px;
        }

        .login-title {
            font-size: 26px;
            font-weight: 700;
            text-align: center;
            margin-bottom: 8px;
            color: #333;
        }

        .login-subtitle {
            font-size: 14px;
            text-align: center;
            color: #888;
            margin-bottom: 24px;
        }

        .brand-tag {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            font-size: 13px;
            padding: 4px 10px;
            border-radius: 999px;
            background: #fff4e6;
            color: #ff7a1a;
            margin: 0 auto 12px;
        }

        .brand-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: #ff7a1a;
        }

        .form-label {
            font-size: 14px;
            color: #555;
        }

        .form-control {
            border-radius: 999px;
            padding: 10px 14px;
        }

        .btn-login {
            border-radius: 999px;
            padding: 10px 0;
            font-weight: 600;
            letter-spacing: 1px;
        }

        .register-link {
            font-size: 14px;
        }

        .footer-text {
            font-size: 12px;
            color: #aaa;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<div class="login-card">
    <div class="text-center">
        <div class="brand-tag">
            <span class="brand-dot"></span>
            <span>外卖点餐系统</span>
        </div>
    </div>

    <div class="login-title">用户登录</div>
    <div class="login-subtitle">欢迎回来，请登录后继续点餐</div>

    <!-- 提示信息 -->
    <%
        Object msg = request.getAttribute("msg");
        if (msg != null) {
    %>
    <div class="alert alert-danger py-2" role="alert">
        <%= msg %>
    </div>
    <%
        }
    %>

    <form action="login" method="post">
        <div class="mb-3">
            <label class="form-label">用户名</label>
            <input type="text" name="username" class="form-control" placeholder="请输入用户名" required>
        </div>

        <div class="mb-3">
            <label class="form-label">密码</label>
            <input type="password" name="password" class="form-control" placeholder="请输入密码" required>
        </div>

        <button type="submit" class="btn btn-primary w-100 btn-login mt-2">
            登录
        </button>
    </form>

    <div class="d-flex justify-content-between align-items-center mt-3 register-link">
        <span>还没有账号？</span>
        <!-- 这里保持你的原来链接地址 register -->
        <a href="register" class="text-decoration-none">去注册 &raquo;</a>
    </div>

    <div class="footer-text">
        © 外卖系统
    </div>
</div>

<!-- Bootstrap JS，可要可不要 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
