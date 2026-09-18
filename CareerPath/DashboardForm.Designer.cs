namespace CareerPath
{
    partial class DashboardForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            label1 = new Label();
            lblWelcome = new Label();
            btnAPS = new Button();
            btnCareers = new Button();
            btnCourses = new Button();
            btnApplications = new Button();
            btnAppTracking = new Button();
            btnJobs = new Button();
            btnLogout = new Button();
            SuspendLayout();
            // 
            // label1
            // 
            label1.Font = new Font("Segoe UI", 13.8F, FontStyle.Bold, GraphicsUnit.Point, 0);
            label1.Location = new Point(12, 9);
            label1.Name = "label1";
            label1.Size = new Size(775, 36);
            label1.TabIndex = 15;
            label1.Text = "[NMU_DASHBOARD]";
            // 
            // lblWelcome
            // 
            lblWelcome.AutoSize = true;
            lblWelcome.Font = new Font("Segoe UI", 10.8F, FontStyle.Bold, GraphicsUnit.Point, 0);
            lblWelcome.ForeColor = Color.ForestGreen;
            lblWelcome.Location = new Point(268, 14);
            lblWelcome.Name = "lblWelcome";
            lblWelcome.Size = new Size(91, 25);
            lblWelcome.TabIndex = 16;
            lblWelcome.Text = "Welcome";
            // 
            // btnAPS
            // 
            btnAPS.Font = new Font("Segoe UI Semibold", 10.8F, FontStyle.Bold, GraphicsUnit.Point, 0);
            btnAPS.Location = new Point(69, 78);
            btnAPS.Name = "btnAPS";
            btnAPS.Size = new Size(200, 59);
            btnAPS.TabIndex = 17;
            btnAPS.Text = "APS Calculator";
            btnAPS.UseVisualStyleBackColor = true;
            // 
            // btnCareers
            // 
            btnCareers.Font = new Font("Segoe UI Semibold", 10.8F, FontStyle.Bold);
            btnCareers.Location = new Point(69, 165);
            btnCareers.Name = "btnCareers";
            btnCareers.Size = new Size(200, 61);
            btnCareers.TabIndex = 18;
            btnCareers.Text = "Career Recommendations";
            btnCareers.UseVisualStyleBackColor = true;
            // 
            // btnCourses
            // 
            btnCourses.Font = new Font("Segoe UI Semibold", 10.8F, FontStyle.Bold);
            btnCourses.Location = new Point(69, 255);
            btnCourses.Name = "btnCourses";
            btnCourses.Size = new Size(200, 66);
            btnCourses.TabIndex = 19;
            btnCourses.Text = "Course Search";
            btnCourses.UseVisualStyleBackColor = true;
            // 
            // btnApplications
            // 
            btnApplications.Font = new Font("Segoe UI Semibold", 10.8F, FontStyle.Bold);
            btnApplications.Location = new Point(69, 341);
            btnApplications.Name = "btnApplications";
            btnApplications.Size = new Size(200, 63);
            btnApplications.TabIndex = 20;
            btnApplications.Text = "Apply for a Course";
            btnApplications.UseVisualStyleBackColor = true;
            // 
            // btnAppTracking
            // 
            btnAppTracking.Font = new Font("Segoe UI Semibold", 10.8F, FontStyle.Bold);
            btnAppTracking.Location = new Point(69, 426);
            btnAppTracking.Name = "btnAppTracking";
            btnAppTracking.Size = new Size(200, 67);
            btnAppTracking.TabIndex = 21;
            btnAppTracking.Text = "Application Tracking";
            btnAppTracking.UseVisualStyleBackColor = true;
            // 
            // btnJobs
            // 
            btnJobs.Font = new Font("Segoe UI Semibold", 10.8F, FontStyle.Bold);
            btnJobs.Location = new Point(69, 521);
            btnJobs.Name = "btnJobs";
            btnJobs.Size = new Size(200, 67);
            btnJobs.TabIndex = 22;
            btnJobs.Text = "Graduate Jobs";
            btnJobs.UseVisualStyleBackColor = true;
            // 
            // btnLogout
            // 
            btnLogout.BackColor = Color.IndianRed;
            btnLogout.CausesValidation = false;
            btnLogout.ForeColor = SystemColors.Control;
            btnLogout.Location = new Point(1698, 16);
            btnLogout.Name = "btnLogout";
            btnLogout.Size = new Size(94, 29);
            btnLogout.TabIndex = 23;
            btnLogout.Text = "Log Out";
            btnLogout.UseVisualStyleBackColor = false;
            // 
            // DashboardForm
            // 
            AutoScaleDimensions = new SizeF(8F, 20F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(1846, 772);
            Controls.Add(btnLogout);
            Controls.Add(btnJobs);
            Controls.Add(btnAppTracking);
            Controls.Add(btnApplications);
            Controls.Add(btnCourses);
            Controls.Add(btnCareers);
            Controls.Add(btnAPS);
            Controls.Add(lblWelcome);
            Controls.Add(label1);
            Name = "DashboardForm";
            Text = "DashboardForm";
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        public Label label1;
        private Label lblWelcome;
        private Button btnAPS;
        private Button btnCareers;
        private Button btnCourses;
        private Button btnApplications;
        private Button btnAppTracking;
        private Button btnJobs;
        private Button btnLogout;
    }
}