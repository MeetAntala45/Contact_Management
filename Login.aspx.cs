using System;
using System.Data.SqlClient;
using System.Configuration;

namespace ContactManagement
{
    public partial class Login : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["ContactDB"].ConnectionString;

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text;
            string password = txtPassword.Text;  

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                 SqlCommand cmd = new SqlCommand("SELECT PasswordHash FROM Users WHERE Username = @Username", con);
                cmd.Parameters.AddWithValue("@Username", username);

                con.Open();
                object result = cmd.ExecuteScalar();

                if (result != null)
                {
                    string storedPassword = result.ToString();  

                    if (password == storedPassword) 
                    {
                        Session["Username"] = username;
                        Response.Redirect("Contact.aspx");
                    }
                    else
                    {
                        lblMessage.Text = "Invalid username or password.";
                    }
                }
                else
                {
                    lblMessage.Text = "Invalid username or password.";
                }
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }
    }
}
