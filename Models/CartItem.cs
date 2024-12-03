namespace WebApp.Models;

    public class CartItem
    {
        public int CartItemId { get; set; }
        public int CartId { get; set; }
        public int ProductId { get; set; }
        public int Quantity { get; set; }

        // Navigation properties
        public Cart Cart { get; set; }
        public Products Product { get; set; }
    }

