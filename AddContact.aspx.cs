using System;
using MySql.Data.MySqlClient;
using System.Configuration;

namespace ContactManagement
{
    public partial class AddContact : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["ContactDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Response.Redirect("Login.aspx");
            }
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Login.aspx");
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string contactName = txtContactName.Text;
            string contactPhone = txtContactPhone.Text;
            string username = Session["Username"]?.ToString();

            if (string.IsNullOrEmpty(username))
            {
                lblMessage.Text = "User is not logged in.";
                return;
            }

            if (contactPhone.Length != 10)
            {
                lblMessage.Text = "Please enter a 10-digit phone number.";
                return;
            }

            using (MySqlConnection con = new MySqlConnection(connectionString))
            {
                MySqlCommand getUserIdCmd = new MySqlCommand("SELECT UserID FROM Users WHERE Username = @Username", con);
                getUserIdCmd.Parameters.AddWithValue("@Username", username);

                con.Open();
                object userIdResult = getUserIdCmd.ExecuteScalar();
                con.Close();

                if (userIdResult == null)
                {
                    lblMessage.Text = "User not found.";
                    return;
                }

                int userId = Convert.ToInt32(userIdResult);

                // Check if the contact name already exists for this user
                MySqlCommand checkNameCmd = new MySqlCommand("SELECT COUNT(*) FROM Contacts WHERE ContactName = @Name AND UserID = @UserID", con);
                checkNameCmd.Parameters.AddWithValue("@Name", contactName);
                checkNameCmd.Parameters.AddWithValue("@UserID", userId);

                con.Open();
                object nameExistsResult = checkNameCmd.ExecuteScalar();
                int nameExists = Convert.ToInt32(nameExistsResult);
                con.Close();

                if (nameExists > 0)
                {
                    lblMessage.Text = "Contact name already exists.";
                    return;
                }

                // Check if the contact phone number already exists for this user
                MySqlCommand checkPhoneCmd = new MySqlCommand("SELECT COUNT(*) FROM Contacts WHERE ContactPhone = @Phone AND UserID = @UserID", con);
                checkPhoneCmd.Parameters.AddWithValue("@Phone", contactPhone);
                checkPhoneCmd.Parameters.AddWithValue("@UserID", userId);

                con.Open();
                object phoneExistsresult = checkPhoneCmd.ExecuteScalar();
                int phoneExists = Convert.ToInt32(phoneExistsresult);
                con.Close();

                if (phoneExists > 0)
                {
                    lblMessage.Text = "Contact number already exists with other.";
                    return;
                }

                 MySqlCommand cmd = new MySqlCommand("INSERT INTO Contacts (ContactName, ContactPhone, UserID) VALUES (@Name, @Phone, @UserID)", con);
                cmd.Parameters.AddWithValue("@Name", contactName);
                cmd.Parameters.AddWithValue("@Phone", contactPhone);
                cmd.Parameters.AddWithValue("@UserID", userId);

                con.Open();
                int rowsInserted = cmd.ExecuteNonQuery();
                if (rowsInserted > 0)
                {
                    Response.Redirect("Contact.aspx");
                }
                con.Close();
            }
        }
    }
}
