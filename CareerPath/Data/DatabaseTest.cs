using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Text;
namespace CareerPath.Data
{
    public class DatabaseTest
    {
        public static bool TestConnection()
        {
            try
            {
                using (SqlConnection connection = DatabaseHelper.GetConnection())
                {
                    connection.Open();
                    return true;
                }
            }
            catch
            {
                return false;
            }
        }
    }
}
