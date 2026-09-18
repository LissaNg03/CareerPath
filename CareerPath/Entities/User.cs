using System;
using System.Collections.Generic;
using System.Text;

namespace CareerPath.Entities
{
    public class User
    {
        public int UserId { get; set; }

        public string FirstName { get; set; } = "";

        public string LastName { get; set; } = "";

        public string Email { get; set; } = "";

        public string PasswordHash { get; set; } = "";

        public string UserType { get; set; } = "";

        public DateTime CreatedAt { get; set; }
    }
}
