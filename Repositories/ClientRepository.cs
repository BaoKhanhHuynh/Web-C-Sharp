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
		// Gán giá tr? m?c ??nh cho Icon và Images n?u chúng ch?a ???c thi?t l?p
		client.Icon ??= "fa fa-quote-left"; // S? d?ng toán t? null-coalescing
		client.Images ??= "testimonial-1.jpg";

		// ??m b?o SQL an toàn v?i tham s? hóa
		var sql = @"INSERT INTO Client (Icon, Name, Position, Description, Images) 
                VALUES (@Icon, @Name, @Position, @Description, @Images)";

		// Th?c thi câu l?nh SQL v?i ??i t??ng client
		connection.Execute(sql, client);

	}
}