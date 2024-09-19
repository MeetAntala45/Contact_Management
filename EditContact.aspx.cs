using System;
using MySql.Data.MySqlClient;
using System.Configuration;

namespace ContactManagement
{
    public partial class EditContact : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["ContactDB"].ConnectionString;
        int contactId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["ContactId"] != null)
                {
                    contactId = Convert.ToInt32(Request.QueryString["ContactId"]);
                    LoadContactData();
                }
            }
        }

        private void LoadContactData()
        {
            using (MySqlConnection con = new MySqlConnection(connectionString))
            {
                MySqlCommand cmd = new MySqlCommand("SELECT ContactName, ContactPhone FROM Contacts WHERE ContactID = @ContactID", con);
                cmd.Parameters.AddWithValue("@ContactID", contactId);

                con.Open();
                MySqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtContactName.Text = reader["ContactName"].ToString();
                    txtContactPhone.Text = reader["ContactPhone"].ToString();
                }
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
            contactId = Convert.ToInt32(Request.QueryString["ContactId"]);

            using (MySqlConnection con = new MySqlConnection(connectionString))
            {
                string query = "UPDATE Contacts SET ContactName = @ContactName, ContactPhone = @ContactPhone WHERE ContactID = @ContactID";
                MySqlCommand cmd = new MySqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ContactName", contactName);
                cmd.Parameters.AddWithValue("@ContactPhone", contactPhone);
                cmd.Parameters.AddWithValue("@ContactID", contactId);

                try
                {
                    con.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                         Response.Redirect("Contact.aspx?updated=true");
                    }
                    else
                    {
                        lblMessage.Text = "Update failed. Contact not found.";
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error: " + ex.Message;
                }
            }

             
        }


    }
}
