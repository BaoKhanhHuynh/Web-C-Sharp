using System.Data;
using Dapper;
using WebApp.Repositories;

namespace WebApp.Models;
public class OrdersRepository : BaseRepository
    {
    public OrdersRepository(IDbConnection connection) : base(connection)
    {
    }

    public IEnumerable<Orders> GetAll()
    {
        var sql = "SELECT * FROM Orders";
        return connection.Query<Orders>(sql);
    }

    public Orders GetById(int orderId)
    {
        var sql = "SELECT * FROM Orders WHERE OrderId = @OrderId";
        return connection.QueryFirstOrDefault<Orders>(sql, new { OrderId = orderId });
    }

    public void Create(Orders orders)
    {
        var sql = "INSERT INTO Orders (MemberId, TotalAmount, FirstName, LastName, Address," +
            " Country, State, Note, City, Phone, Email,OrderDate, Status) VALUES (@MemberId, @TotalAmount," +
            " @FirstName, @LastName, @Address, @Country, @State, @Note, @City, @Phone, @Email, @OrderDate, @Status)";
        connection.Execute(sql, orders);
    }

    public Orders SaveOrder(Orders orders)
    {
        var sql = @"
        INSERT INTO Orders (MemberId, TotalAmount, FirstName, LastName, Address, 
                            Country, State, Note, City, Phone, Email, OrderDate, Status) 
        VALUES (@MemberId, @TotalAmount, @FirstName, @LastName, @Address, @Country, 
                @State, @Note, @City, @Phone, @Email, @OrderDate,  @Status);
        SELECT CAST(SCOPE_IDENTITY() AS INT)";

        int orderId = connection.QuerySingle<int>(sql, orders);

        orders.OrderId = orderId;

        return orders;
    }

    public void Edit(Orders orders)
    {
        var sql = "UPDATE Orders SET MemberId = @MemberId, TotalAmount = @TotalAmount, FirstName = @FirstName, LastName = @LastName, Address = @Address, Country = @Country, State = @State, Note = @Note, City = @City, Phone = @Phone, Email = @Email, OrderDate = @OrderDate,  Status = @Status  WHERE OrderId = @OrderId";
        connection.Execute(sql, new { orders.OrderId, orders.MemberId, orders.TotalAmount, orders.FirstName, orders.LastName, orders.Address,
        orders.Country, orders.State, orders.Note, orders.City, orders.Phone, orders.Email, orders.OrderDate});
    }

    public void Delete(int orderId)
    {
        var sql = "DELETE FROM Orders WHERE OrderId = @OrderId";
        connection.Execute(sql, new { OrderId = orderId });
    }
}
