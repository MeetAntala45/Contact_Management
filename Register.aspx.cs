using System;
using MySql.Data.MySqlClient;
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

            using (MySqlConnection con = new MySqlConnection(connectionString))
            {
                MySqlCommand checkUserCmd = new MySqlCommand("SELECT COUNT(*) FROM Users WHERE Username = @Username", con);
                checkUserCmd.Parameters.AddWithValue("@Username", username);

                con.Open();
               object userExistsResult = checkUserCmd.ExecuteScalar();
                int userExists = Convert.ToInt32(userExistsResult);

                if (userExists > 0)
                {
                    lblMessage.Text = "User already exists. Try a different username.";
                }
                else
                {
                    MySqlCommand cmd = new MySqlCommand("INSERT INTO Users (Username, Password, Email) VALUES (@Username, @Password, @Email)", con);
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
