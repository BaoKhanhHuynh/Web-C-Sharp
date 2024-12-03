
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace WebApp.Controllers;
public class HomeController : BaseController
{
    public IActionResult Index()
    {
        ViewBag.Services = Provider.Service.GetServices();
        ViewBag.Client = Provider.Client.GetLastFiveClients();
        ViewBag.Team = Provider.Team.GetTeam();
        ViewBag.Pro = Provider.Products.GetAll();
        ViewBag.Menu = Provider.Menus.GetAll();
        return View();
    }
    public IActionResult About()
    {
        return View();
    }

    public IActionResult Service()
    {
        return View();
    }

    public IActionResult Menu([FromQuery] string? search)
    {
        if (string.IsNullOrEmpty(search))
        {
            ViewBag.Pro = Provider.Products.GetAll();
        }
        else
        {
            ViewBag.Pro = Provider.Products.SearchByKeyword(search);
        }

        ViewBag.Menu = Provider.Menus.GetAll();
        return View();
    }

    public IActionResult Contact()
    {
        return View();
    }
    public IActionResult Team()
    {
        return View();
    }
    public IActionResult Testimonial()
    {
        return View();
    }
}