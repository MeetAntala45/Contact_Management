using System;
using System.Data.SqlClient;
using System.Configuration;

namespace ContactManagement
{
    public partial class Register : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["ContactDB"].ConnectionString;

       

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text;
            string password = txtPassword.Text; 
            string email = txtEmail.Text;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand checkUserCmd = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Username = @Username", con);
                checkUserCmd.Parameters.AddWithValue("@Username", username);

                con.Open();
                int userExists = (int)checkUserCmd.ExecuteScalar();

                if (userExists > 0)
                {
                    lblMessage.Text = "User already exists. Try a different username.";
                }
                else
                {
                     SqlCommand cmd = new SqlCommand("INSERT INTO Users (Username, Password, Email) VALUES (@Username, @Password, @Email)", con);
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Password", password);  
                    cmd.Parameters.AddWithValue("@Email", email);

                    cmd.ExecuteNonQuery();
                    Response.Redirect("Login.aspx"); // Redirect back to login after successful registration
                }
            }
        }
    }
}
