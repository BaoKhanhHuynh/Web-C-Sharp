using Microsoft.AspNetCore.Mvc;

namespace WebApp.Controllers;
public class MemberController : BaseController
{
    public IActionResult Index()
    {
        return View(Provider.Member.GetMembers());
    }
}