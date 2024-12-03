using System.Data;
using Dapper;
using WebApp.Models;

namespace WebApp.Repositories;
public class ClientRepository : BaseRepository
{
	public ClientRepository(IDbConnection connection) : base(connection)
	{
	}

	public IEnumerable<Client> GetLastFiveClients()
	{
		return connection.Query<Client>("SELECT TOP 5 * FROM Client ORDER BY ClientId DESC");
	}


	public IEnumerable<Client> GetClients()
	{
		return connection.Query<Client>("SELECT * FROM Client");
	}

	public void Add(Client client)
	{
		// G�n gi� tr? m?c ??nh cho Icon v� Images n?u ch�ng ch?a ???c thi?t l?p
		client.Icon ??= "fa fa-quote-left"; // S? d?ng to�n t? null-coalescing
		client.Images ??= "testimonial-1.jpg";

		// ??m b?o SQL an to�n v?i tham s? h�a
		var sql = @"INSERT INTO Client (Icon, Name, Position, Description, Images) 
                VALUES (@Icon, @Name, @Position, @Description, @Images)";

		// Th?c thi c�u l?nh SQL v?i ??i t??ng client
		connection.Execute(sql, client);

	}
}