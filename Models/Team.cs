namespace WebApp.Models;

public class Team
{
    public int TeamId { get; set; }
    public string Images { get; set; } = null!;
    public string Name { get; set; } = null!;
    public string Position { get; set; } = null!;
    public string Icon { get; set; } = null!;
}