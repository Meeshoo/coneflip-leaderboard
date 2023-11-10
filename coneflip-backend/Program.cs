using Microsoft.Data.Sqlite;
using Dapper;
using System.Data;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddCors();
builder.Services.AddScoped<IDbConnection>(_ =>
    new SqliteConnection(builder.Configuration.GetConnectionString("Database")));

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// app.UseCors(x => x
//     .AllowAnyMethod()
//     .AllowAnyHeader()
//     .WithOrigins(app.Configuration.GetSection("AllowedHosts").Get<string[]>()!)
//     .AllowCredentials());

app.UseCors(x => x
    .AllowAnyMethod()
    .AllowAnyHeader()
    .WithOrigins("http://127.0.0.1:5500")
    .AllowCredentials());

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.MapGet("/gettopthree", (IDbConnection db) =>
{
   return db.Query<Coneflip>("SELECT [name],[score],[video_link] FROM [coneflip] ORDER BY score DESC LIMIT 3");
});

app.MapPost("/addscore", (Coneflip coneflip, IDbConnection db) =>
{

    if (coneflip.Score == 0 || coneflip.Name == null || coneflip.Video_link == null)
    {
        return Results.BadRequest();
    }

    db.Execute("INSERT INTO [coneflip] VALUES(@name, @score, @video_link)", new
    {
        name = coneflip.Name,
        score  = coneflip.Score,
        video_link = coneflip.Video_link
    });

    return Results.Ok();
});

app.Run();

public class Coneflip
{
    public required string Name { get; set; }
    public required int Score { get; set; }
    public required string Video_link { get; set; }
}
