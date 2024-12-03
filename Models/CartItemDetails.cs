namespace WebApp.Models
{
    public class CartItemDetails
    {
        public int ProductId { get; set; }
        public int Quantity { get; set; }
        public Products? Products { get; set; }
    }
}
