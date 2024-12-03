using System.Data;
using System.Threading.Tasks;
using Dapper;

namespace WebApp.Repositories
{
    public class DashboardRepository : BaseRepository
    {
        public DashboardRepository(IDbConnection connection) : base(connection)
        {
        }

        public async Task<int> CountProductsAsync()
        {
            var sql = "SELECT Count(*) FROM Products";
            return await connection.QuerySingleAsync<int>(sql);
        }

        public async Task<int> CountMenuAsync()
        {
            var sql = "SELECT Count(*) FROM Menus";
            return await connection.QuerySingleAsync<int>(sql);
        }

        public async Task<int> CountOrdersAsync()
        {
            var sql = "SELECT Count(*) FROM Orders";
            return await connection.QuerySingleAsync<int>(sql);
        }

        public async Task<int> CountMembersAsync()
        {
            var sql = "SELECT Count(*) FROM Member";
            return await connection.QuerySingleAsync<int>(sql);
        }
    }
}
