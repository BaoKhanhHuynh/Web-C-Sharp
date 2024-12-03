using System.Data;
using Dapper;
using WebApp.Repositories;

namespace WebApp.Models;

public class ProductRepository : BaseRepository
{
    public ProductRepository(IDbConnection connection) : base(connection)
    {
    }

    public IEnumerable<Products> GetAll()
    {
        var sql = @"SELECT *
                FROM Products p
                LEFT JOIN Menus m ON p.MenuId = m.MenuId";
        return connection.Query<Products, Menus, Products>(sql, (product, menu) =>
        {
            product.Menus = menu;
            return product;
        }, splitOn: "MenuId");
    }

    public IEnumerable<Products> SearchByKeyword(string keyword)
    {
        var sql = @"SELECT *
            FROM Products p
            LEFT JOIN Menus m ON p.MenuId = m.MenuId
            WHERE LOWER(p.Name) LIKE LOWER('%' + @keyword + '%')";
        var products = connection.Query<Products, Menus, Products>(
            sql,
            (product, menu) =>
            {
                product.Menus = menu;
                return product;
            },
            new { keyword },
            splitOn: "MenuId"
        );

        return products;
    }

    public Products GetById(int productId)
    {
        var sql = "SELECT * FROM Products WHERE ProductId = @ProductId";
        return connection.QueryFirstOrDefault<Products>(sql, new { ProductId = productId });
    }

    public void Create(Products product)
    {
        var sql = "INSERT INTO Products (Name, Description, Price, Images, MenuId, CreateAt) VALUES (@Name, @Description, @Price, @Images, @MenuId, @CreateAt)";
        connection.Execute(sql, product);
    }

    public void Edit(Products product)
    {
        var sql = "UPDATE Products SET Name = @Name, Description = @Description, Price = @Price, Images = @Images, MenuId = @MenuId, CreateAt=@CreateAt WHERE ProductId = @ProductId";
        connection.Execute(sql, product);
    }

    public void Delete(int productId)
    {
        var sql = "DELETE FROM Products WHERE ProductId = @ProductId";
        connection.Execute(sql, new { ProductId = productId });
    }
}
