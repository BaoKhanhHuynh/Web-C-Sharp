using Microsoft.AspNetCore.Mvc;
using WebApp.Controllers;

namespace WebApp.Areas.Dashboard.Controllers
{
    [Area("admin")]
    public class HomeController : BaseController
    {
        public async Task<ActionResult> Index()
        {
            ViewBag.Menu = await Provider.Dashboard.CountMenuAsync();
            ViewBag.Product = await Provider.Dashboard.CountProductsAsync();
            ViewBag.Order = await Provider.Dashboard.CountOrdersAsync();
            ViewBag.Member = await Provider.Dashboard.CountMembersAsync();

            return View();
        }
        public JsonResult GetDataOrder()
        {
            var data = Provider.Orders.GetAll()
                .GroupBy(o => o.OrderDate.Year)
                .Select(g => new
                {
                    Year = g.Key,
                    Value = g.Sum(o => o.TotalAmount)
                })
                .ToList();
            return Json(data);
        }

        public JsonResult GetDataProduct()
        {
            var data = Provider.Products.GetAll()
                .GroupBy(p => p.CreateAt.Month)
                .Select(g => new
                {
                    Month = g.Key,
                    ProductCount = g.Count() 
                })
                .OrderBy(g => g.Month) 
                .ToList();

            return Json(data);
        }


    }
}
