using CareerPath.Data;
namespace CareerPath
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            StartPosition = FormStartPosition.CenterScreen;

            //if (DatabaseTest.TestConnection())
            //{
            //    MessageBox.Show(
            //        "Database connection successful!",
            //        "CareerPath",
            //        MessageBoxButtons.OK,
            //        MessageBoxIcon.Information
            //    );
            //}
            //else
            //{
            //    MessageBox.Show(
            //        "Database connection failed!",
            //        "CareerPath",
            //        MessageBoxButtons.OK,
            //        MessageBoxIcon.Error
            //    );
            //}
        }



        private void btnSignUp_Click(object sender, EventArgs e)
        {
            RegisterForm form = new RegisterForm();
            form.ShowDialog();
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            LoginForm form = new LoginForm();
            form.ShowDialog();
        }
    }
}
