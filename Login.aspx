<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ContactManagement.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server" class="d-flex justify-content-center align-items-center vh-100">
        <div class="card p-4 shadow" style="width: 400px;">
            <h2 class="text-center mb-4">Login</h2>
            
             <div class="mb-3">
                <asp:Label ID="lblUsername" runat="server" Text="Username:" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter your username"></asp:TextBox>
            </div>
            
            <div class="mb-3">
                <asp:Label ID="lblPassword" runat="server" Text="Password:" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter your password"></asp:TextBox>
            </div>
            
             <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary w-100" OnClick="btnLogin_Click" />
            
            <!-- Error  -->
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red" CssClass="d-block mt-3"></asp:Label>
            
            <!-- Register   -->
            <div class="text-center mt-4">
                <asp:Label ID="lblRegisterPrompt" runat="server" Text="Haven't registered yet?" CssClass="d-block mb-2"></asp:Label>
                <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-outline-secondary w-100" OnClick="btnRegister_Click" />
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
