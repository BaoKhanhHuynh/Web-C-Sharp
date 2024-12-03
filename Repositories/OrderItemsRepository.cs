using System.Data;
using Dapper;
using WebApp.Models;

namespace WebApp.Repositories;
public class OrderItemsRepository : BaseRepository
{
    public OrderItemsRepository(IDbConnection connection) : base(connection)
    {
    }

    public IEnumerable<OrderItems> GetOderItems()
    {
        return connection.Query<OrderItems>("SELECT * FROM  OrderItems ");
    }
    public int Add(OrderItems obj)
    {
        return connection.Execute("AddOrderItems", new
        {
            obj.OrderItemId,
            obj.OrderId,
            obj.ProductId,
            obj.Quantity,
            obj.Price,
        },
        commandType: CommandType.StoredProcedure);
    }
    public IEnumerable<OrderItems> GetAll()
    {
        var sql = "SELECT * FROM OrderItems";
        return connection.Query<OrderItems>(sql);
    }

    public OrderItems GetById(int OrderItemsId)
    {
        var sql = "SELECT * FROM OrderItems WHERE OrderItemId = @OrderItemId";
        return connection.QueryFirstOrDefault<OrderItems>(sql, new { OrderItemId = OrderItemsId });
    }
    public void Create(OrderItems OrderItems)
    {
        var sql = "INSERT INTO OrderItems (OrderId, ProductId, Quantity, Price) VALUES ( @OrderId, @ProductId, @Quantity,  @Price)";
        connection.Execute(sql, OrderItems);
    }
    public void Edit(OrderItems OrderItems)
    {
        var sql = "UPDATE OrderItems SET OrderId = @OrderId, ProductId = @ProductId, Quantity = @Quantity, Price = @Price WHERE OrderItemId = @OrderItemId";
        connection.Execute(sql, new { OrderItems.OrderId, OrderItems.ProductId, OrderItems.Quantity, OrderItems.Price, OrderItems.OrderItemId });
    }
    public void Delete(int id)
    {
        var sql = "DELETE FROM OrderItems WHERE OrderItemId = @OrderItemId";
        connection.Execute(sql, new { OrderItemId = id });
    }

}