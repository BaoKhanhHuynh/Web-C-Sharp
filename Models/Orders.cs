namespace WebApp.Models;
public class Orders
{
    public int OrderId { get; set; }
    public int MemberId { get; set; }
    public decimal TotalAmount { get; set; }
    public string FirstName { get; set; } = null!;
    public string LastName { get; set; } = null!;
    public string Address { get; set; } = null!;
    public string Country { get; set; } = null!;
    public string State { get; set; } = null!;
    public string Note { get; set; } = null!;
    public string City { get; set; } = null!;
    public string Phone { get; set; } = null!;
    public string Email { get; set; } = null!;
    public DateTime OrderDate { get; set; } = DateTime.Now;
    public OrderStatus Status { get; set; }

    // Navigation property
    public Member meber { get; set; }

    // Relationships
    public ICollection<OrderItems> OrderItems { get; set; }
}

