using System.Data;
using Dapper;
using WebApp.Models;

namespace WebApp.Repositories;
public class ServiceRepository : BaseRepository
{
    public ServiceRepository(IDbConnection connection) : base(connection)
    {
    }

    public IEnumerable<Service> GetServices()
    {
        return connection.Query<Service>("SELECT * FROM Service");
    }

}