using CareerPath.Data;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace CareerPath
{
    public partial class RegisterForm : Form
    {
        public RegisterForm()
        {
            InitializeComponent();
            StartPosition = FormStartPosition.CenterScreen;
            TopMost = true;
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void textBox4_TextChanged(object sender, EventArgs e)
        {

        }

        private void btnRegister_Click(object sender, EventArgs e)
        {
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;
            string userType = cmbUserType.Text;

            if (string.IsNullOrWhiteSpace(firstName) ||
                string.IsNullOrWhiteSpace(lastName) ||
                string.IsNullOrWhiteSpace(email) ||
                string.IsNullOrWhiteSpace(password) ||
                string.IsNullOrWhiteSpace(userType))
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

                    string query = @"
                INSERT INTO CareerPath.Users
                (
                    FirstName,
                    LastName,
                    Email,
                    PasswordHash,
                    UserType
                )
                VALUES
                (
                    @FirstName,
                    @LastName,
                    @Email,
                    @PasswordHash,
                    @UserType
                )";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@FirstName", firstName);
                        command.Parameters.AddWithValue("@LastName", lastName);
                        command.Parameters.AddWithValue("@Email", email);
                        command.Parameters.AddWithValue("@PasswordHash", password);
                        command.Parameters.AddWithValue("@UserType", userType);

                        command.ExecuteNonQuery();
                    }
                }

                MessageBox.Show(
                    "Registration successful!",
                    "CareerLink",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Information
                );

                var form = new LoginForm();
                form.Show();

                this.Close();
            }
            catch (SqlException ex)
            {
                if (ex.Number == 2627 || ex.Number == 2601)
                {
                    MessageBox.Show(
                        "An account with this email already exists.",
                        "Registration",
                        MessageBoxButtons.OK,
                        MessageBoxIcon.Warning
                    );
                }
                else
                {
                    MessageBox.Show(
                        "Database error:\n\n" + ex.Message,
                        "Registration",
                        MessageBoxButtons.OK,
                        MessageBoxIcon.Error
                    );
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

        private void btnLogin_Click(object sender, EventArgs e)
        {
            var form = new LoginForm();
            form.Show();
            this.Hide();
        }
    }
}
