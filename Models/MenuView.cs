namespace WebApp.Models
{
    public class MenuView
    {
        public string SearchQuery { get; set; }
        public List<Menus> Menu { get; set; }
        public List<Products> Products { get; set; }
    }
}
