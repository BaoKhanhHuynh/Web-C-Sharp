using System.Data;
using System.Data.SqlClient;

namespace  WebApp.Models;

public abstract class BaseProvider
{
    IDbConnection? connection; // tao ket noi
    IConfiguration configuration; //Lay chuoi ket noi
    public BaseProvider(IConfiguration configuration){
        this.configuration = configuration;
    }

    protected IDbConnection Connection => connection ??= new SqlConnection(configuration.GetConnectionString("Retoran"));
}