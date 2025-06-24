<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditContact.aspx.cs" Inherits="ContactManagement.EditContact" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Edit Contact</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap CSS & Icons -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" rel="stylesheet" />

    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        }

        .navbar {
            background-color: #ffffff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            color: black;
            padding: 10px 80px;
            border-bottom: 1px solid #dee2e6;
        }

        .navbar .navbar-brand,
        .navbar .nav-link {
            color: black !important;
            font-weight: 500;
        }

        .navbar .nav-link:hover {
            background-color: rgba(255,255,255,0.1);
            border-radius: 5px;
        }

        .container-box {
            max-width: 500px;
            background-color: #ffffff;
            padding: 40px;
            margin: 50px auto;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #2c3e50;
            font-weight: 700;
        }

        .form-label {
            font-weight: 600;
            color: #495057;
        }

        .form-control {
            height: 45px;
            border-radius: 8px;
        }

        .btn-primary {
            height: 45px;
            font-weight: 600;
            border-radius: 8px;
            background-color: #343a40;
            border-color: #343a40;
        }

        .btn-primary:hover {
            background-color: #212529;
            border-color: #1d2124;
        }

        .icon-large {
            font-size: 24px;
        }

        .message-label {
            font-size: 0.95rem;
            margin-top: 10px;
            text-align: center;
            display: block;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg">
            <a class="navbar-brand" href="Contact.aspx">
                <i class="bi bi-house-door-fill"></i> Home
            </a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <asp:LinkButton ID="btnLogout" runat="server" CssClass="nav-link" OnClick="btnLogout_Click">
                            <i class="bi bi-box-arrow-right icon-large"></i> Logout
                        </asp:LinkButton>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Edit Contact Form -->
        <div class="container container-box">
            <h2>Edit Contact</h2>

            <div class="form-group">
                <asp:Label ID="lblContactName" runat="server" Text="Full Name" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtContactName" runat="server" CssClass="form-control" />
            </div>

            <div class="form-group">
                <asp:Label ID="lblContactPhone" runat="server" Text="Phone Number" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtContactPhone" runat="server" TextMode="Number" CssClass="form-control" />
            </div>

            <div class="form-group text-center">
                <asp:Button ID="btnSave" runat="server" Text="Save Changes" CssClass="btn btn-primary w-100" OnClick="btnSave_Click" />
            </div>

            <asp:Label ID="lblMessage" runat="server" ForeColor="Red" CssClass="message-label" />
        </div>
    </form>

    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
