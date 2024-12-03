using System;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using WebApp.Controllers;
using WebApp.Models;

namespace WebApp.Areas.Admin.Controllers;
[Area("Admin")]
public class MemberController : BaseController
{
    public IActionResult Index()
    {
        return View(
        Provider.Member.GetAll()
        );
    }

    public IActionResult Create()
    {
        return View();
    }
    [HttpPost]
    public IActionResult Create(Member obj)
    {
        try
        {
            Provider.Member.Create(obj);

            return Redirect("/admin/member");
        }
        catch (Exception ex)
        {
            return View(obj);
        }
    }

    public IActionResult Edit(int id)
    {
        return View(Provider.Member.GetById(id));
    }
    [HttpPost]
    public IActionResult Edit(Member obj)
    {
        try
        {
            Provider.Member.Edit(obj);

            return Redirect("/admin/member");
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
            Provider.Member.Delete(id);
            return Redirect("/admin/member");
        }
        catch (Exception ex) { return NotFound(); }
    }
}


