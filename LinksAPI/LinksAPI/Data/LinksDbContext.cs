using Microsoft.EntityFrameworkCore;
using LinksAPI.Models;
namespace LinksAPI.Data;

public class LinksDbContext : DbContext
{
    public LinksDbContext(DbContextOptions<LinksDbContext> options) : base(options) { }   // Constructor

    // Properties
    public DbSet<Event> Events { get; set; }
    public DbSet<Group> Groups { get; set; }
    public DbSet<GroupMember> GroupMembers { get; set; }
    public DbSet<Message> Messages { get; set; }
    public DbSet<User> Users { get; set; }
    public DbSet<Friend> Friends { get; set; }
}