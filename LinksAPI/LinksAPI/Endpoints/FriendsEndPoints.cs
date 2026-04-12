namespace LinksAPI.Endpoints;

using LinksAPI.Data;
using LinksAPI.Models;
using Microsoft.EntityFrameworkCore;
public static class FriendsEndPoints
{
    public static void MapFriendsEndPoints(this WebApplication app)
    {
        app.MapPost("/friends", async (int senderId, int receiverId, LinksDbContext db) =>
        {
            var user = await db.Friend.FindAsync(senderId);
            var friend = await db.Friend.FindAsync(receiverId);
            if (user == null || friend == null)
            {
                return Results.NotFound();
            }

            var existingFriendship = await db.Friend.AnyAsync(f =>
                (f.SenderId == senderId && f.ReceiverId == receiverId) ||
                (f.SenderId == senderId && f.ReceiverId == receiverId));

            if (existingFriendship)
            {
                return Results.BadRequest("Friendship already exists");
            }

            var friendship = new Friend
            {
                SenderId = senderId,
                ReceiverId = receiverId,
                Status = "Pending",
                CreatedAt = DateTime.UtcNow
            };
            db.Friend.Add(friendship);
            await db.SaveChangesAsync();
            return Results.Created($"/friends/{friendship.Id}", friendship);
        });

        app.MapGet("/friends/{userId}", async (int userId, LinksDbContext db) =>
        {
            var user = await db.Users.FindAsync(userId);
            if (user == null)
            {
                return Results.NotFound();
            }

            var friends = await db.Friend
                .Where(f => f.SenderId == userId || f.ReceiverId == userId)
                .ToListAsync();

            return Results.Ok(friends);
        });
    }
}