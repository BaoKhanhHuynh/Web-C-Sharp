using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.Extensions.FileSystemGlobbing.Internal.Patterns;
using WebApp.Models;
using WebApp.Services;


var builder = WebApplication.CreateBuilder(args);
builder.Services.
           AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
           .AddCookie()
           .AddGoogle(p =>{
               p.ClientId = builder.Configuration["Authentication:Google:ClientId"] ?? throw new Exception("Not found");
               p.ClientSecret = builder.Configuration["Authentication:Google:ClientSecret"] ?? throw new Exception("Not found");
           });


builder.Services.Configure<VnPay>(builder.Configuration.GetSection("Payment:VnPay"));

builder.Services.AddDistributedMemoryCache();
builder.Services.AddTransient<VnPayService>();
builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(120); 
    options.Cookie.HttpOnly = true;
    options.Cookie.IsEssential = true;
});
builder.Services.AddHttpContextAccessor();




builder.Services.AddMvc();
var app = builder.Build();


app.UseStaticFiles();
//app.MapGet("/", () => "Hello World!");
app.UseAuthentication();
app.UseAuthorization();

app.UseSession();
app.MapControllerRoute(
              name: "default",
              pattern: "{controller=Home}/{action=Index}/{id?}");

app.MapControllerRoute(
     name: "area",
     pattern: "{area:exists}/{controller=Home}/{action=Index}/{id?}");
app.Run();
