using Microsoft.AspNetCore.Mvc;
using WebApp.Controllers;
using WebApp.Models;

namespace WebApp.Areas.Admin.Controllers;
[Area("Admin")]
// [Athorize(Role = "Admin")]
public class OrdersController : BaseController
{
    public IActionResult Index()
    {
        return View(
        Provider.Orders.GetAll()
        );
    }

    public IActionResult Create()
    {
        return View();
    }
    [HttpPost]
    public IActionResult Create(Orders obj)
    {
        try
        {
            Provider.Orders.Create(obj);

            return Redirect("/admin/orders");
        }
        catch (Exception ex)
        {
            return View(obj);
        }
    }

    public IActionResult Edit(int id)
    {
        return View(Provider.Orders.GetById(id));
    }
    [HttpPost]
    public IActionResult Edit(int id, Orders obj)
    {
        try
        {
            obj.OrderId = id;
            Provider.Orders.Edit(obj);

            return Redirect("/admin/orders");
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
            Provider.Orders.Delete(id);
            return Redirect("/admin/orders");
        }
        catch (Exception ex) { return NotFound(); }
    }
}

