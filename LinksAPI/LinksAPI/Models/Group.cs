namespace LinksAPI.Models;

public class Group
{
    public int Id { get; set; }
    public int EventId { get; set; }
    public int MaxMembers { get; set; }
    public string? GroupStatus { get; set; }
    public DateTime CreatedDate { get; set; }
    public int CreatorId { get; set; }
}