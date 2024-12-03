using System.Data;

namespace WebApp.Repositories;
public abstract class BaseRepository
{
    protected IDbConnection connection;
    public BaseRepository(IDbConnection connection)
    {
        this.connection = connection;
    }


}