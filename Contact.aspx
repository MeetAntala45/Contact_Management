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
 .navbar-nav {
    display: flex;
    flex-direction: row;
    align-items: center;
}

.nav-item {
    margin-right: 15px;  
    border:1px solid transparent;
}
.nav-item:hover {
   border:1px solid black;
   border-radius:4px;
}

 .nav-link.active {
    color: #0056b3; 
    font-weight: bold;
}
  
.nav-item .nav-link {
    display: flex;
    align-items: center;
}

.nav-item .nav-link svg {
    margin-right: 5px;  
}

 .search-container {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
}

 .gridview {
    border-collapse: collapse;
    width: 100%;
}

.gridview th, .gridview td {
    border: none;
    padding: 8px;
    text-align: left;
}

.gridview tr {
    border-bottom: 1px solid #ddd;
}

.gridview th {
    border-bottom: 2px solid #333;
    font-weight: bold;
}

.gridview thead {
    background-color: #f4f4f4;
}

.gridview .btn {
    border: none;
    background: none;
}

.icon-edit, .icon-delete, .copy-btn {
    border: none;
    background: none;
    cursor: pointer;
    font-size: 16px;
}

.icon-edit {
    color: black;
}

.icon-edit:hover {
    color: blue;
}

.icon-delete {
    color: #007bff;
}

.icon-delete:hover {
    color: red;
}

.copy-btn {
    color: #000;
}

.copy-btn:hover {
    color: #0056b3;
}
.icon-large {
    font-size: 32px; 
    color: #007bff;  
}

    </style>
</head>
<body>
    <form id="form1" runat="server">
        
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="Contact.aspx">
        <i class="bi bi-house-door"></i> <!-- Home  -->
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
            <li class="nav-item">
                <asp:LinkButton ID="btnAddContact" runat="server" CssClass="nav-link icon-button" OnClick="btnAdd_Click" >
                <i class="bi bi-person-add"></i>  
                    </asp:LinkButton>
            </li>
            <li class="nav-item">
                <asp:LinkButton ID="btnSearch" runat="server" CssClass="nav-link icon-button" OnClick="btnSearch_Click" >
                <i class="bi bi-search"></i> 
                </asp:LinkButton>
            </li>
            <li class="nav-item">
        <asp:LinkButton ID="btnExport" runat="server" CssClass="nav-link" OnClick="btnExport_Click">
            <i class="bi bi-download"> </i> &nbsp Export Contacts
        </asp:LinkButton>
    </li>
            <li class="nav-item">
                <asp:LinkButton ID="btnLogout" runat="server" CssClass="nav-link icon-button" OnClick="btnLogout_Click" >
                <i class="bi bi-box-arrow-right icon-large"></i> <!-- Logout -->
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
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clipboard" viewBox="0 0 16 16">
                        <path d="M4 1.5H3a2 2 0 0 0-2 2V14a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V3.5a2 2 0 0 0-2-2h-1v1h1a1 1 0 0 1 1 1V14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V3.5a1 1 0 0 1 1-1h1z"/>
                        <path d="M9.5 1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5zm-3-1A1.5 1.5 0 0 0 5 1.5v1A1.5 1.5 0 0 0 6.5 4h3A1.5 1.5 0 0 0 11 2.5v-1A1.5 1.5 0 0 0 9.5 0z"/>
                    </svg>
                </button>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>




        </div>

        <div class="container">
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
        </div>

        <!-- JavaScript and Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.js"></script>
        <script>
            function copyPhone(phoneNumber) {
                var tempInput = document.createElement("input");
                tempInput.value = phoneNumber;
                document.body.appendChild(tempInput);
                tempInput.select();
                tempInput.setSelectionRange(0, 99999); 
                document.execCommand("copy");
                document.body.removeChild(tempInput);
                alert("Phone number copied: " + phoneNumber);
            }
        </script>
    </form>
</body>
</html>