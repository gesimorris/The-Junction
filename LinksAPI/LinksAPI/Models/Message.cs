namespace LinksAPI.Models;

public class Message
{
    public int Id { get; set; }
    public string? MessageText { get; set; }
    public int UserId { get; set; }
    public int GroupId { get; set; }
    public DateTime MessageDate { get; set; }
}