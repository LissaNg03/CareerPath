using Microsoft.Data.SqlClient;
namespace CareerPath.Data
{
    public class DatabaseHelper
    {

        private static readonly string connectionString = "Data Source=.\\SQLEXPRESS;" +
                                                          "Initial Catalog = CareerPathDB;" +
                                                          " Integrated Security = True; " +
                                                          "Trust Server Certificate=True";

        public static SqlConnection GetConnection()
        {
            return new SqlConnection(connectionString);
        }

    }
}
