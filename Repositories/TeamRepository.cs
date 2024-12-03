using System.Data;
using Dapper;
using WebApp.Models;

namespace WebApp.Repositories;
public class TeamRepository : BaseRepository
{
    public TeamRepository(IDbConnection connection) : base(connection)
    {
    }

    public IEnumerable<Team> GetTeam()
    {
        return connection.Query<Team>("SELECT * FROM Team");
    }

}