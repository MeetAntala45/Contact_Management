<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ContactManagement.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" rel="stylesheet" />

    <style>
        body {
            background: linear-gradient(to right, #f5f9ff, #eaf4fb);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .login-card {
            background-color: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            max-width: 1300px;
        }

        .login-card h2 {
            text-align: center;
            margin-bottom: 30px;
            font-weight: 700;
            color: #2c3e50;
        }

        .form-control {
            border-radius: 8px;
            height: 35px;

        }

        .btn-primary {
            height: 45px;
            font-weight: 600;
            border-radius: 8px;
            transition: background-color 0.3s ease;
            background-color: #0056b3;
        }

        .btn-primary:hover {
            background-color: #343a40;
        }

        .btn-outline-secondary {
            height: 45px;
            font-weight: 600;
            border-radius: 8px;
        }

        .text-danger {
            font-size: 0.9rem;
        }

        .mt-4 {
            margin-top: 1.5rem !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-card">
            <h2>Login</h2>

            <div class="mb-3">
                <label for="txtUsername" class="form-label">Username</label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" />
            </div>

            <div class="mb-3">
                <label for="txtPassword" class="form-label">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"  />
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary w-100" OnClick="btnLogin_Click" />

            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger mt-3 d-block text-center" />

            <div class="text-center mt-4">
                <asp:Label ID="lblRegisterPrompt" runat="server" Text="Don't have an account?" CssClass="d-block mb-2" />
                <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-outline-secondary w-100" OnClick="btnRegister_Click" />
            </div>
        </div>
    </form>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
