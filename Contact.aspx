<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="ContactManagement.Contact" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Contact Management</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" rel="stylesheet" />

    <style>
        body {
            background: linear-gradient(to right, #f8f9fa, #e9ecef);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
        }

        .navbar {
            background-color: #ffffff;
            padding: 12px 40px;
            border-bottom: 1px solid #dee2e6;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        .navbar-brand, .nav-link {
            color: #343a40 !important;
            font-weight: 500;
            margin-left:30px;
        }

        .nav-link:hover, .nav-link.active {
            background-color: #f1f1f1;
            border-radius: 5px;
        }

        .container-main {
            margin-top: 40px;
            max-width: 960px;
        }

        .search-container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.08);
            margin-bottom: 30px;
        }

        .form-control {
            border-radius: 8px;
            border-color: #ced4da;
        }

        .btn-primary {
                                    background-color: #0056b3;

            border-color: #0d6efd;
            border-radius: 8px;
        }

        .btn-primary:hover {
                        background-color: #343a40;
            border-color: #0a58ca;
            border-color: #0a58ca;
        }

        .btn-light {
            border-radius: 8px;
        }
.gridview {
    width: 100%;
    border-collapse: collapse;
    margin-top: 30px;
    font-size: 16px;
    background-color: #ffffff;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    border-radius: 8px;
    overflow: hidden;
}

.gridview th {
background: #d6d8db ;
color: black;
    text-align: left;
    padding: 14px 20px;
    font-weight: 600;
    font-size: 16px;
        border-bottom: 1px solid #dee2e6;

}

.gridview td {
    padding: 14px 20px;
    border-bottom: 1px solid #dee2e6;
    color: #212529;
}

.gridview tr:last-child td {
    border-bottom: none;
}

.gridview tr:hover {
    background-color: #f1f3f5;
    transition: background-color 0.2s ease-in-out;
}

.icon-edit, .icon-delete, .copy-btn {
    cursor: pointer;
    font-size: 18px;
    margin-right: 10px;
    padding: 6px 10px;
    border-radius: 6px;
    transition: background-color 0.3s ease;
    border: none;
    background-color: transparent;
}

.icon-edit { color: #0dcaf0; }
.icon-edit:hover { background-color: #e3f6f9; }

.icon-delete { color: #dc3545; }
.icon-delete:hover { background-color: #f8d7da; }

.copy-btn { color: #28a745; }
.copy-btn:hover { background-color: #d4edda; }


        .alert {
            padding: 15px;
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
            border-radius: 8px;
            margin-top: 20px;
        }

        footer {
            margin-top: 450px;
            padding: 20px 0;
            background-color: #f8f9fa;
            color: #6c757d;
            text-align: center;
            font-size: 15px;
            border-top: 1px solid #dee2e6;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg navbar-light">
            <div class="container">
                <a class="navbar-brand" href="Contact.aspx">
                    <i class="bi bi-journal-richtext"></i>
                    <asp:Label ID="lblUsername" runat="server" />
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <asp:LinkButton ID="btnAddContact" runat="server" CssClass="nav-link" OnClick="btnAdd_Click">
                                <i class="bi bi-person-plus-fill"></i> Add Contact
                            </asp:LinkButton>
                        </li>
                        <li class="nav-item">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="nav-link" OnClick="btnSearch_Click">
                                <i class="bi bi-search"></i> Search
                            </asp:LinkButton>
                        </li>
                        <li class="nav-item d-flex align-items-center">
                            <asp:FileUpload ID="fileUploadContacts" runat="server" CssClass="form-control form-control-sm me-2" />
                            <asp:Button ID="btnImport" runat="server" Text="Import" CssClass="btn btn-light btn-sm" OnClick="btnImport_Click" />
                        </li>
                        <li class="nav-item">
                            <asp:LinkButton ID="btnExport" runat="server" CssClass="nav-link" OnClick="btnExport_Click">
                                <i class="bi bi-cloud-arrow-down-fill"></i> Export
                            </asp:LinkButton>
                        </li>
                        <li class="nav-item">
                            <asp:LinkButton ID="btnLogout" runat="server" CssClass="nav-link" OnClick="btnLogout_Click">
                                <i class="bi bi-box-arrow-left"></i> Logout
                            </asp:LinkButton>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container container-main">
            <asp:Panel ID="searchContainer" runat="server" CssClass="search-container" Visible="false">
                <h4>Search Contacts</h4>
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control mb-2" placeholder="Enter name or number" />
                <asp:Button ID="btnPerformSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnPerformSearch_Click" />
            </asp:Panel>

            <h4 class="text-center mb-4">Your Contacts</h4>

            <asp:GridView ID="gvContacts" runat="server" AutoGenerateColumns="False" DataKeyNames="ContactID" OnRowCommand="gvContacts_RowCommand" CssClass="gridview">
                <Columns>
                    <asp:BoundField DataField="ContactName" HeaderText="Name" />
                    <asp:BoundField DataField="ContactPhone" HeaderText="Phone" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CommandArgument='<%# Eval("ContactID") %>' CssClass="icon-edit">
                                <i class="bi bi-pencil-square"></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("ContactID") %>' CssClass="icon-delete">
                                <i class="bi bi-trash3-fill"></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <button type="button" class="copy-btn btn btn-sm p-0 bg-transparent" onclick="copyPhone('<%# Eval("ContactPhone") %>')">
                                <i class="bi bi-clipboard-check"></i>
                            </button>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <asp:Label ID="lblMessage" runat="server" CssClass="alert" Visible="false" />
        </div>

        <footer>
            &copy; 2024 Contact Management System | All Rights Reserved
        </footer>

        <script>
            function copyPhone(phoneNumber) {
                navigator.clipboard.writeText(phoneNumber).then(function () {
                    alert('Phone number copied to clipboard: ' + phoneNumber);
                });
            }
        </script>
    </form>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
