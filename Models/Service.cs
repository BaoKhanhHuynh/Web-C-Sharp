namespace WebApp.Models;

public class Service
{
    public int ServiceId { get; set; }
    public string Icon { get; set; } = null!;
    public string Name { get; set; } = null!;
    public string Description { get; set; } = null!;
}
