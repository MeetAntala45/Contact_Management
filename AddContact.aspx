<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddContact.aspx.cs" Inherits="ContactManagement.AddContact" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Contact</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" rel="stylesheet" />
    <style>
        .icon-large {
            font-size: 32px; 
            color: #007bff;  
        }

        /* Hide number input spinners for WebKit browsers */
        input[type=number]::-webkit-inner-spin-button,
        input[type=number]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        /* Hide number input spinners for Firefox */
        input[type=number] {
            -moz-appearance: textfield;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="Contact.aspx">
                <i class="bi bi-house-door"></i> <!-- Home -->
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <asp:LinkButton ID="btnLogout" runat="server" CssClass="nav-link icon-button" OnClick="btnLogout_Click" >
                            <i class="bi bi-box-arrow-right icon-large"></i> <!-- Logout  -->
                        </asp:LinkButton>
                    </li>
                </ul>
            </div>
        </nav>

        <div class="container mt-4">
            <h2>Add Contact</h2>

            <div class="form-group">
                <asp:Label ID="lblContactName" runat="server" Text="Name:" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtContactName" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblContactPhone" runat="server" Text="Phone:" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtContactPhone" runat="server" TextMode="Number" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary" OnClick="btnSave_Click" />
            </div>

            <div>
                <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>
