<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="ContactManagement.Register" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Register</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" rel="stylesheet" />
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f7f7f7;
            margin: 0;
        }
        .form-container {
            background-color: #fff;
            padding: 40px 50px; 
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
           
            max-width: 600px;  
             width: 100%;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .btn-primary {
            width: 100%;
            padding: 10px;
            font-size: 1.1rem;
        }
        input[type="number"]::-webkit-inner-spin-button, 
        input[type="number"]::-webkit-outer-spin-button { 
            -webkit-appearance: none; 
            margin: 0; 
        }
        h2.text-center {
            margin-bottom: 30px;
            font-weight: bold;
            color: #333;
        }
        .text-danger {
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <h2 class="text-center">Register</h2>

             <div class="form-group">
                <label for="txtUsername">Username</label>
                <asp:TextBox 
                    ID="txtUsername" 
                    runat="server" 
                    CssClass="form-control" 
                    Placeholder="Enter username" 
                    required="required"></asp:TextBox>
            </div>

             <div class="form-group">
                <label for="txtPassword">Password</label>
                <asp:TextBox 
                    ID="txtPassword" 
                    runat="server" 
                    CssClass="form-control" 
                    TextMode="Password" 
                    Placeholder="Enter password" 
                    required="required"></asp:TextBox>
            </div>

             <div class="form-group">
                <label for="txtEmail">Email</label>
                <asp:TextBox 
                    ID="txtEmail" 
                    runat="server" 
                    CssClass="form-control" 
                    TextMode="Email" 
                    Placeholder="Enter email" 
                    required="required"></asp:TextBox>
            </div>

             <asp:Button 
                ID="btnRegister" 
                runat="server" 
                CssClass="btn btn-primary" 
                Text="Register" 
                OnClick="btnRegister_Click" />

            <!-- Message Label -->
            <asp:Label 
                ID="lblMessage" 
                runat="server" 
                CssClass="text-danger mt-3 d-block"></asp:Label>
        </div>
    </form>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
