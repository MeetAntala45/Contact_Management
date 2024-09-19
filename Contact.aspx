<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="ContactManagement.Contact" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Contact Management</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" rel="stylesheet" />
    <style>
        /* Navbar Styling */
        .navbar {
            background-color: #000000;
            padding: 10px 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .navbar-brand, .nav-link {
            color: #fff !important;
        }

        .nav-link {
            margin-right: 15px;
            font-size: 18px;
        }

        .nav-link:hover, .nav-link.active {
            background-color: rgba(255, 255, 255, 0.2);
            border-radius: 5px;
        }

        .navbar-toggler-icon {
            background-color: #fff;
        }

        /* Container Styling */
        .container {
            margin-top: 20px;
            max-width: 900px;
            padding: 20px;
            background-color: #f8f9fa;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h2, h3 {
            color: #333;
            font-weight: 600;
        }

        /* Search Box */
        .search-container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .form-control {
            border-radius: 5px;
            border-color: #007bff;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }

        /* GridView Styling */
        .gridview {
            width: 100%;
            margin-top: 20px;
        }

        .gridview th {
            background-color: #007bff;
            color: #fff;
            padding: 10px;
        }

        .gridview td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        .gridview tr:hover {
            background-color: #f1f1f1;
        }

        .icon-edit, .icon-delete, .copy-btn {
            cursor: pointer;
            font-size: 18px;
            transition: color 0.3s;
        }

        .icon-edit {
            color: #ffc107;
        }

        .icon-edit:hover {
            color: #ff9800;
        }

        .icon-delete {
            color: #dc3545;
        }

        .icon-delete:hover {
            color: #c82333;
        }

        .copy-btn {
            color: #28a745;
        }

        .copy-btn:hover {
            color: #218838;
        }

        /* Button Styling */
        .btn {
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        /* Alert Styling */
        .alert {
            padding: 15px;
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
            border-radius: 5px;
            margin-top: 20px;
        }

        /* Footer Styling */
        footer {
            margin-top: 40px;
            padding: 20px 0;
            background-color: #007bff;
            color: #fff;
            text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg navbar-light">
    <a class="navbar-brand" href="Contact.aspx">
        <i class="bi bi-house-door"></i> Home
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <asp:LinkButton ID="btnAddContact" runat="server" CssClass="nav-link" OnClick="btnAdd_Click">
                    <i class="bi bi-person-add"></i> Add Contact
                </asp:LinkButton>
            </li>
            <li class="nav-item">
                <asp:LinkButton ID="btnSearch" runat="server" CssClass="nav-link" OnClick="btnSearch_Click">
                    <i class="bi bi-search"></i> Search
                </asp:LinkButton>
            </li>
            <li class="nav-item">
                <div class="nav-link">
                    <asp:FileUpload ID="fileUploadContacts" runat="server" CssClass="d-inline-block" />
                    <asp:Button ID="btnImport" runat="server" Text="Import" CssClass="btn btn-light btn-sm ml-2" OnClick="btnImport_Click" />
                </div>
            </li>
            <li class="nav-item">
                <asp:LinkButton ID="btnExport" runat="server" CssClass="nav-link" OnClick="btnExport_Click">
                    <i class="bi bi-download"></i> Export Contacts
                </asp:LinkButton>
            </li>
            <li class="nav-item">
                <asp:LinkButton ID="btnLogout" runat="server" CssClass="nav-link" OnClick="btnLogout_Click">
                    <i class="bi bi-box-arrow-right"></i> Logout
                </asp:LinkButton>
            </li>
        </ul>
    </div>
</nav>


        <!-- Search Contact -->
        <div class="container search-container" id="searchContainer" runat="server" visible="false">
            <h3>Search Contacts</h3>
            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" Placeholder="Enter name or number"></asp:TextBox>
            <asp:Button ID="btnPerformSearch" runat="server" Text="Search" CssClass="btn btn-primary mt-2" OnClick="btnPerformSearch_Click" />
        </div>

        <!-- Contacts -->
        <div class="container">
            <h2>Welcome, <asp:Label ID="lblUsername" runat="server"></asp:Label></h2>
            <h3>Your Contacts</h3>

            <asp:GridView ID="gvContacts" runat="server" AutoGenerateColumns="False" DataKeyNames="ContactID" OnRowCommand="gvContacts_RowCommand" CssClass="gridview">
                <Columns>
                    <asp:BoundField DataField="ContactName" HeaderText="Name" />
                    <asp:BoundField DataField="ContactPhone" HeaderText="Phone" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CommandArgument='<%# Eval("ContactID") %>' CssClass="icon-edit">
                                <i class="bi bi-pencil"></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("ContactID") %>' CssClass="icon-delete">
                                <i class="bi bi-trash"></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <button type="button" class="copy-btn" onclick="copyPhone('<%# Eval("ContactPhone") %>')">
                                <i class="bi bi-clipboard"></i>
                            </button>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <div class="container">
            <asp:Label ID="lblMessage" runat="server" CssClass="alert" Visible="false"></asp:Label>
        </div>

        <!-- JavaScript and Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
            // Copy phone number function
            function copyPhone(phoneNumber) {
                navigator.clipboard.writeText(phoneNumber).then(function () {
                    alert('Phone number copied: ' + phoneNumber);
                });
            }
        </script>
    </form>
</body>
</html>
