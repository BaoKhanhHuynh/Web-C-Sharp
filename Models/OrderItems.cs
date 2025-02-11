﻿namespace WebApp.Models;
    public class OrderItems
    {
        public int OrderItemId { get; set; }
        public int OrderId { get; set; }
        public int ProductId { get; set; }
        public int Quantity { get; set; }
        public decimal Price { get; set; }

        // Navigation properties
        public Orders? Orders { get; set; }
        public Products? Product { get; set; }
    }

