using Microsoft.AspNetCore.Mvc;
using WebApp.Models;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using System.Security.Claims;
using WebApp.Services;
using Microsoft.AspNetCore.Authentication.Google;

namespace WebApp.Controllers
{
    public class AuthController : BaseController
    {
        public IActionResult Register()
        {
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> Register(Member obj)
        {
            obj.MemberId = Guid.NewGuid().ToString().Replace("-", "");
            obj.Password = Helper.Hash(obj.Password);
            int ret = Provider.Member.Add(obj);
            if (ret > 0)
            {
                return Redirect("/auth/login");
            }

            TempData["RegisterError"] = "Registration failed. Please try again.";
            return View(obj);
        }
        public IActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> Login(LoginModel model)
        {
            var member = Provider.Member.Login(model);
            if (member != null) {
                List<Claim> list = new List<Claim>
                {
                    new Claim(ClaimTypes.NameIdentifier, member.MemberId),
                    new Claim(ClaimTypes.Email, member.Email),
                    new Claim(ClaimTypes.GivenName, member.GivenName),
                    new Claim(ClaimTypes.Surname, member.Surname),
                    new Claim(ClaimTypes.Name, member.Name),
                    new Claim(ClaimTypes.Role, member.Role),
                };

                ClaimsIdentity claimsIdentity = new ClaimsIdentity(list, CookieAuthenticationDefaults.AuthenticationScheme);

                await HttpContext.SignInAsync(new ClaimsPrincipal(claimsIdentity), new AuthenticationProperties
                {
                    IsPersistent = model.Rem
                });

                return Redirect("/Home");  
            }
            else {
                TempData["err"] = "Email or password incorrect!!!";
                return View(model); 
            }
        }
        public IActionResult GoogleLogin()
        {
            string? url = Url.Action("googleresponse", "auth", null, protocol: Request.Scheme);
            if (string.IsNullOrEmpty(url))
            {
                return Redirect("/auth/login");
            }
            AuthenticationProperties properties = new AuthenticationProperties
            {
                RedirectUri = url
            };
            return Challenge(properties, GoogleDefaults.AuthenticationScheme);

        }

        public async Task<IActionResult> GoogleResponse()
        {
            var result = await HttpContext.AuthenticateAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            if (result != null && result.Principal != null)
            {
                var claims = result.Principal.Claims;
                var member = new Member
                {
                    MemberId = claims.FirstOrDefault(static p => p.Type == ClaimTypes.NameIdentifier).Value,
                    Name = claims.FirstOrDefault(static p => p.Type == ClaimTypes.Name).Value,
                    GivenName = claims.FirstOrDefault(static p => p.Type == ClaimTypes.GivenName).Value,
                    Surname = claims.FirstOrDefault(static p => p.Type == ClaimTypes.Surname).Value,
                    Email = claims.FirstOrDefault(static p => p.Type == ClaimTypes.Email).Value,
                    Password = Helper.Hash("ulhjkhjk")

                };
                Provider.Member.Add(member);
                return Redirect("/home/index");
            }
            return View();
        }
        [HttpPost] 
        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);

            return RedirectToAction("Login");
        }
    }
}
