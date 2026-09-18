using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using CareerPath.Entities;
namespace CareerPath
{
    public partial class DashboardForm : Form
    {
        private User loggedInUser;
        public DashboardForm(User user)
        {
            InitializeComponent();
            StartPosition = FormStartPosition.CenterScreen;
            TopMost = true;
            loggedInUser = user;
            lblWelcome.Text = $"{loggedInUser.FirstName}";
        }
    }
}
