using System;
using MySql.Data.MySqlClient;
using System.Configuration;
using System.Data;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.IO;

namespace ContactManagement
{
    public partial class Contact : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["ContactDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                lblUsername.Text = Session["Username"].ToString();
                if (!IsPostBack || Request.QueryString["updated"] == "true")
                {
                    LoadContacts();
                }
            }
        }

        protected void LoadContacts(string searchQuery = "")
        {
            using (MySqlConnection con = new MySqlConnection(connectionString))
            {
                string query = "SELECT ContactID, ContactName, ContactPhone FROM Contacts WHERE UserID = (SELECT UserID FROM Users WHERE Username = @Username)";
                if (!string.IsNullOrEmpty(searchQuery))
                {
                    query += " AND (ContactName LIKE @SearchQuery OR ContactPhone LIKE @SearchQuery)";
                }
                query += " ORDER BY ContactName";

                MySqlCommand cmd = new MySqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Username", Session["Username"]);
                if (!string.IsNullOrEmpty(searchQuery))
                {
                    cmd.Parameters.AddWithValue("@SearchQuery", "%" + searchQuery + "%");
                }

                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvContacts.DataSource = dt;
                gvContacts.DataBind();
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddContact.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Login.aspx");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            searchContainer.Visible = !searchContainer.Visible;
        }

        protected void btnPerformSearch_Click(object sender, EventArgs e)
        {
            string searchQuery = txtSearch.Text.Trim();
            LoadContacts(searchQuery);
        }

        protected void gvContacts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                int contactId = Convert.ToInt32(e.CommandArgument);
                DeleteContact(contactId);
                Response.Redirect("Contact.aspx"); // Redirect to home page after deletion
            }
            else if (e.CommandName == "Edit")
            {
                int contactId = Convert.ToInt32(e.CommandArgument);
                Response.Redirect("EditContact.aspx?ContactID=" + contactId);
            }
        }

        protected void gvContacts_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int contactId = Convert.ToInt32(gvContacts.DataKeys[e.RowIndex].Value);
            DeleteContact(contactId);
            LoadContacts();  
        }


        protected void DeleteContact(int contactId)
        {
            using (MySqlConnection con = new MySqlConnection(connectionString))
            {
                string query = "DELETE FROM Contacts WHERE ContactID = @ContactID";
                MySqlCommand cmd = new MySqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ContactID", contactId);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
             DataTable dtContacts = GetContactsForExport();

            if (dtContacts.Rows.Count > 0)
            {
                // Convert all contacts from database to CSV format
                string csvData = ConvertToCSV(dtContacts);

                // Set the response to initiate a file download
                Response.Clear();
                Response.ContentType = "text/csv";
                Response.AddHeader("content-disposition", "attachment;filename=Contacts.csv");
                Response.Write(csvData);
                Response.End();
            }
            else
            {
                lblMessage.Text = "No contacts available to export.";
            }
        }

        //  fetch all the contacts and for export
        private DataTable GetContactsForExport()
        {
            using (MySqlConnection con = new MySqlConnection(connectionString))
            {
                string query = "SELECT ContactName, ContactPhone FROM Contacts WHERE UserID = (SELECT UserID FROM Users WHERE Username = @Username)";
                MySqlCommand cmd = new MySqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Username", Session["Username"]);

                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        // converting DataTable to CSV string
        private string ConvertToCSV(DataTable dt)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();

             for (int i = 0; i < dt.Columns.Count; i++)
            {
                sb.Append(dt.Columns[i]);
                if (i < dt.Columns.Count - 1)
                    sb.Append(",");
            }
            sb.AppendLine();

             foreach (DataRow row in dt.Rows)
            {
                for (int i = 0; i < dt.Columns.Count; i++)
                {
                    sb.Append(row[i].ToString());
                    if (i < dt.Columns.Count - 1)
                        sb.Append(",");
                }
                sb.AppendLine();
            }
            return sb.ToString();
        }

        protected void btnImport_Click(object sender, EventArgs e)
        {
            if (fileUploadContacts.HasFile)
            {
                try
                {
                    StreamReader sr = new StreamReader(fileUploadContacts.PostedFile.InputStream);
                    string csvData = sr.ReadToEnd();

                    ImportContacts(csvData);

                    LoadContacts();

                    lblMessage.Text = "Contacts imported successfully.";
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error: " + ex.Message;
                }
            }
            else
            {
                lblMessage.Text = "Please select a CSV file to import.";
            }
        }

        private void ImportContacts(string csvData)
        {
            string username = Session["Username"]?.ToString();
            if (string.IsNullOrEmpty(username))
            {
                lblMessage.Text = "User is not logged in.";
                return;
            }

            using (MySqlConnection con = new MySqlConnection(connectionString))
            {
                MySqlCommand getUserIdCmd = new MySqlCommand("SELECT UserID FROM Users WHERE Username = @Username", con);
                getUserIdCmd.Parameters.AddWithValue("@Username", username);
                con.Open();
                object userIdResult = getUserIdCmd.ExecuteScalar();
                con.Close();

                if (userIdResult == null || userIdResult == DBNull.Value)
                {
                    lblMessage.Text = "User not found.";
                    return;
                }

                int userId = Convert.ToInt32(userIdResult);

                using (StringReader reader = new StringReader(csvData))
                {
                    string line;
                    while ((line = reader.ReadLine()) != null)
                    {
                        string[] fields = line.Split(',');
                        if (fields.Length >= 2)
                        {
                            string contactName = fields[0].Trim();
                            string contactPhone = fields[1].Trim();

                            if (contactPhone.Length != 10)
                            {
                                continue; 
                            }

                            using (MySqlCommand cmd = new MySqlCommand("INSERT INTO Contacts (ContactName, ContactPhone, UserID) VALUES (@Name, @Phone, @UserID)", con))
                            {
                                cmd.Parameters.AddWithValue("@Name", contactName);
                                cmd.Parameters.AddWithValue("@Phone", contactPhone);
                                cmd.Parameters.AddWithValue("@UserID", userId);
                                con.Open();
                                cmd.ExecuteNonQuery();
                                con.Close();
                            }
                        }
                    }
                }
            }
        }
    }
}
