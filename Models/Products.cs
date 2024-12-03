namespace WebApp.Models;

public class Products
{
    public int ProductId { get; set; }
    public string Name { get; set; }
    public string Description { get; set; }
    public string? Images { get; set; }
    public decimal Price { get; set; }
    public int MenuId { get; set; }
    public DateTime CreateAt { get; set; } = DateTime.Now;

    public virtual Menus? Menus { get; set; }
    public ICollection<CartItem> CartItems { get; set; }
    public ICollection<OrderItems> OrderItems { get; set; }
}
