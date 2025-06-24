<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="ContactManagement.Register" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Register</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" rel="stylesheet" />

    <style>
        body {
background: linear-gradient(to right, #f5f9ff, #eaf4fb);
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .register-card {
            background-color: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
        }

        .register-card h2 {
            margin-bottom: 30px;
            font-weight: 700;
            color: #2c3e50;
        }

        .form-control {
            border-radius: 8px;
            height: 45px;
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

        .text-danger {
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="register-card">
            <h2 class="text-center">Create Your Account</h2>

            <div class="mb-3">
                <label for="txtUsername" class="form-label">Username</label>
                <asp:TextBox 
                    ID="txtUsername" 
                    runat="server" 
                    CssClass="form-control" 
                    required="required" />
            </div>

            <div class="mb-3">
                <label for="txtPassword" class="form-label">Password</label>
                <asp:TextBox 
                    ID="txtPassword" 
                    runat="server" 
                    CssClass="form-control" 
                    TextMode="Password" 
                    required="required" />
            </div>

            <div class="mb-4">
                <label for="txtEmail" class="form-label">Email address</label>
                <asp:TextBox 
                    ID="txtEmail" 
                    runat="server" 
                    CssClass="form-control" 
                    TextMode="Email" 
                    required="required" />
            </div>

            <asp:Button 
                ID="btnRegister" 
                runat="server" 
                CssClass="btn btn-primary w-100" 
                Text="Register" 
                OnClick="btnRegister_Click" />

            <asp:Label 
                ID="lblMessage" 
                runat="server" 
                CssClass="text-danger mt-3 d-block text-center" />
        </div>
    </form>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
