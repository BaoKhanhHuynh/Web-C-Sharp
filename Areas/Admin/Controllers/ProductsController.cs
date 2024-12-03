using System;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using WebApp.Controllers;
using WebApp.Models;

namespace WebApp.Areas.Admin.Controllers;
[Area("Admin")]
public class ProductsController : BaseController
{
    public IActionResult Index()
    {
        return View(
        Provider.Products.GetAll()
        );
    }
    public IActionResult Create()
    {
        var menuSelectList = new SelectList(Provider.Menus.GetAll(), "MenuId", "Name");
        ViewBag.MenuSelectList = menuSelectList;
        return View();
    }
    [HttpPost]
    public IActionResult Create(Products product, IFormFile? file)
    {
        try
        {
			// Kiểm tra nếu có file được upload
			if (file != null && file.Length > 0)
			{
				// Đường dẫn tới thư mục images trong wwwroot
				string filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/images", file.FileName);

				// Lưu tệp vào thư mục
				using (var stream = new FileStream(filePath, FileMode.Create))
				{
					file.CopyTo(stream);
				}

				// Gán đường dẫn tệp vào thuộc tính Images của sản phẩm
				product.Images = "/images/" + file.FileName;
			}
			Provider.Products.Create(product);
            return Redirect("/admin/products");
        }
        catch (Exception ex) {return View(product); }
    }

    public IActionResult Edit(int id)
    {
        var product = Provider.Products.GetById(id);
        var menuSelectList = new SelectList(Provider.Menus.GetAll(), "MenuId", "Name", product.MenuId);
        ViewBag.MenuSelectList = menuSelectList;
        return View(product);
    }
	[HttpPost]
	public IActionResult Edit(Products product, IFormFile? file)
	{
		try
		{
			// Kiểm tra nếu có file mới được upload
			if (file != null && file.Length > 0)
			{
				// Đường dẫn tới thư mục images trong wwwroot
				string filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/images", file.FileName);

				// Lưu tệp mới vào thư mục
				using (var stream = new FileStream(filePath, FileMode.Create))
				{
					file.CopyTo(stream);
				}

				// Gán đường dẫn tệp mới vào thuộc tính Images của sản phẩm
				product.Images = "/images/" + file.FileName;
			}
			// Nếu không có file mới, giữ nguyên đường dẫn hình ảnh cũ
			else
			{
				product.Images = Request.Form["Images"];
			}

			// Cập nhật sản phẩm
			Provider.Products.Edit(product);
			return Redirect("/admin/products");
		}
		catch (Exception ex)
		{
			return View(product);
		}
	}

	[HttpPost]
    public IActionResult Delete(int id)
    {
        try
        {
            Provider.Products.Delete(id);
            return Redirect("/admin/products");
        }
        catch(Exception ex) { return NotFound(); }
    }
}
