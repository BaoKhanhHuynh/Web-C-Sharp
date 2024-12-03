using System.Data.SqlClient;
using System.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApp.Controllers;
using WebApp.Models;
using WebApp.Services;

namespace WebApp.Areas.Admin.Controllers;
[Area("Admin")]
public class MenusController : BaseController
{
    //private readonly MenuView _menuView;
    //public MenusController(MenuView menuView)
    //{
    //    _menuView = _menuView;
    //}


    public IActionResult Index()
    {
        return View(Provider.Menus.GetAll());
    }

    public IActionResult Create()
    {
        return View();
    }
    [HttpPost]
    public IActionResult Create(Menus obj)
    {
        try
        {
            Provider.Menus.Create(obj);

            return Redirect("/admin/menus");
        }
        catch (Exception ex)
        {
            return View(obj);
        }
    }

    public IActionResult Edit(int id)
    {
        return View(Provider.Menus.GetById(id));
    }
    [HttpPost]
    public IActionResult Edit(Menus obj)
    {
        try
        {
            Provider.Menus.Edit(obj);

            return Redirect("/admin/menus");
        }
        catch (Exception ex)
        {
            return View(obj);
        }
    }


    [HttpPost]
    public IActionResult Delete(int id)
    {
        try
        {
            Provider.Menus.Delete(id);
            return Redirect("/admin/menus");
        }
        catch (Exception ex) { return NotFound(); }
    }


    //[HttpGet]
    //public IActionResult Index(string search)
    //{
    //    try
    //    {
    //        // Lấy danh sách menu và sản phẩm từ service
    //        var menus = _menuView.GetAll();
    //        var products = _menuView.GetAll();

    //        // Tạo model và trả về view
    //        var model = new MenuView
    //        {
    //            SearchQuery = search,
    //            Menu = menus,
    //            Products = products
    //        };

    //        return View(model);
    //    }
    //    catch (Exception ex)
    //    {
    //        // Xử lý lỗi
    //        Console.WriteLine($"Error: {ex.Message}");
    //        ViewBag.ErrorMessage = "Đã xảy ra lỗi. Vui lòng thử lại sau.";
    //        return View(new MenuView());
    //    }
    //}
}
