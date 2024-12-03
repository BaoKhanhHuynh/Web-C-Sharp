namespace WebApp.Models;

public class Client
{
    public int ClientId { get; set; }
    public string Icon { get; set; } = null!;
    public string Name { get; set; } = null!;
    public string Position { get; set; } = null!;
    public string Description { get; set; } = null!;
    public string Images { get; set; } = null!;
}
