using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Microsoft.Data.SqlClient;
using CareerPath.Data;
using CareerPath.Entities;
namespace CareerPath
{
    public partial class LoginForm : Form
    {
        public LoginForm()
        {
            InitializeComponent();
            StartPosition = FormStartPosition.CenterScreen;
            TopMost = true;
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text;
            string password = txtPassword.Text;

            if(string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                MessageBox.Show(
                   "Please complete all fields.",
                   "Registration",
                   MessageBoxButtons.OK,
                   MessageBoxIcon.Warning
               );
                return;
            }

            try
            {

                using (SqlConnection connection = DatabaseHelper.GetConnection())
                {
                    connection.Open();

                    string sql = "SELECT * FROM CareerPath.Users WHERE Email = @Email AND passwordHash = @PasswordHash;";

                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue("@Email", email);
                        command.Parameters.AddWithValue("@PasswordHash", password);
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                User existingUser = new User()
                                {
                                    UserId = reader.GetInt32(0),
                                    FirstName = reader.GetString(1),
                                    LastName = reader.GetString(2),
                                    Email = reader.GetString(3),
                                    PasswordHash = reader.GetString(4),
                                    UserType = reader.GetString(5),
                                    CreatedAt = reader.GetDateTime(6)
                                };

                                var dashboard = new DashboardForm(existingUser);
                                dashboard.Show();
                                Form1 form1 = new Form1();
                                RegisterForm register = new RegisterForm();
                                register.Close();
                                form1.Hide();
                                this.Close(); 

                                //MessageBox.Show(
                                //      $"Logged In Successfully\n" +
                                //      $"First Name: {existingUser.FirstName}\n" +
                                //      $"Last Name: {existingUser.LastName}\n",
                                //      "Logged In",
                                //      MessageBoxButtons.OK,
                                //      MessageBoxIcon.Information
                                //  );
                            }
                            else
                            {

                                MessageBox.Show(
                                    "Invalid Credentials",
                                    "Credentials Error",
                                    MessageBoxButtons.RetryCancel,
                                    MessageBoxIcon.Warning
                                );
                            }
                        }

                    }
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(
                    "Something went wrong:\n\n" + ex.Message,
                    "Registration",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Error
                );
            }
        }
    }
}
