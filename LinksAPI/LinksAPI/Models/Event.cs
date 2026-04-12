
namespace LinksAPI.Models;

public class Event
{
    public int Id { get; set; }
    public string? Name { get; set; }
    public string? Location { get; set; }
    public DateTime Date { get; set; }
    public int NumOfAttendees { get; set; }
    public int MaxAttendees { get; set; }
    public string? Description { get; set; }
}