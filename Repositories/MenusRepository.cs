using System.Data;
using Dapper;
using WebApp.Repositories;

namespace WebApp.Models;
public class MenusRepository : BaseRepository
{
	public MenusRepository(IDbConnection connection) : base(connection)
	{
	}

	public IEnumerable<Menus> GetAll()
	{
		var sql = "SELECT * FROM Menus";
		return connection.Query<Menus>(sql);
	}

    public Menus GetById(int menuId)
    {
        var sql = "SELECT * FROM Menus WHERE MenuId = @MenuId";
        return connection.QueryFirstOrDefault<Menus>(sql, new { MenuId = menuId });
    }


    public void Create(Menus menus)
	{
		var sql = "INSERT INTO Menus (Name) VALUES (@Name)";
		connection.Execute(sql, menus);
	}

	public void Edit(Menus menus)
	{
		var sql = "UPDATE Menus SET Name = @Name WHERE MenuId = @MenuId";
		connection.Execute(sql, new { menus.Name, menus.MenuId});
	}

	public void Delete(int id)
	{
		var sql = "DELETE FROM Menus WHERE MenuId = @MenuId";
		connection.Execute(sql, new { MenuId = id});
	}
}