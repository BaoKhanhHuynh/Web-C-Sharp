using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;
using System.Security.Claims;
using System.Collections.Generic;
using WebApp.Models;
using WebApp.Services;
using Microsoft.Extensions.Options;

namespace WebApp.Controllers
{
	public class CartController : BaseController
	{
		private const string CartSessionKey = "Cart";
		private readonly VnPayService _service;
		private readonly VnPay _vnPayConfig;

		public CartController(VnPayService service, IOptions<VnPay> vnPayConfig)
		{
			_service = service;
			_vnPayConfig = vnPayConfig.Value;
		}

		public IActionResult Index()
		{
			var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier);
			if (userIdClaim == null)
			{
				return RedirectToAction("Login", "Auth");
			}

			var cart = GetCartFromSession();
			if (cart != null)
			{
				foreach (var item in cart.Items)
				{
					var product = Provider.Products.GetById(item.ProductId);
					if (product != null)
					{
						item.Products = product;
					}
				}
			}

			ViewBag.CartItems = cart?.Items ?? new List<CartItemDetails>();

			return View();
		}
		public IActionResult Checkout()
		{
			var cart = GetCartFromSession();
			if (cart != null)
			{
				foreach (var item in cart.Items)
				{
					var product = Provider.Products.GetById(item.ProductId);
					if (product != null)
					{
						item.Products = product;
					}
				}
			}
			ViewBag.CartItems = cart?.Items ?? new List<CartItemDetails>();
			return View();
		}

		[HttpPost]
		public IActionResult Feedback(Client request)
		{
			Provider.Client.Add(request);
			return Redirect("/home/index");
		}

		public IActionResult Success()
		{
			return View();
		}

		public IActionResult AddToCart(int productId, int quantity = 1)
		{
			var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier);
			if (userIdClaim == null)
			{
				return RedirectToAction("Login", "Auth");
			}

			var cart = GetCartFromSession() ?? new Cart();

			var existingItem = cart.Items.Find(item => item.ProductId == productId);
			if (existingItem != null)
			{
				existingItem.Quantity += quantity;
			}
			else
			{
				cart.Items.Add(new CartItemDetails
				{
					ProductId = productId,
					Quantity = quantity
				});
			}

			SaveCartToSession(cart);

			return RedirectToAction("Index", "Cart");
		}

		public IActionResult RemoveFromCart(int productId)
		{
			var cart = GetCartFromSession();
			if (cart != null)
			{
				var itemToRemove = cart.Items.Find(item => item.ProductId == productId);
				if (itemToRemove != null)
				{
					cart.Items.Remove(itemToRemove);
					SaveCartToSession(cart);
				}
			}

			return RedirectToAction("Index", "Cart");
		}

		public IActionResult UpdateQuantity(int productId, int quantity)
		{
			if (quantity <= 0)
			{
				return RedirectToAction("RemoveFromCart", new { productId });
			}

			var cart = GetCartFromSession();
			if (cart != null)
			{
				var itemToUpdate = cart.Items.Find(item => item.ProductId == productId);
				if (itemToUpdate != null)
				{
					itemToUpdate.Quantity = quantity;
					SaveCartToSession(cart);
				}
			}

			return RedirectToAction("Index", "Cart");
		}

		private Cart GetCartFromSession()
		{
			var cartJson = HttpContext.Session.GetString(CartSessionKey);
			if (string.IsNullOrEmpty(cartJson))
			{
				return null;
			}

			return JsonConvert.DeserializeObject<Cart>(cartJson);
		}

		private void SaveCartToSession(Cart cart)
		{
			var cartJson = JsonConvert.SerializeObject(cart);
			HttpContext.Session.SetString(CartSessionKey, cartJson);
		}


		[HttpPost]
		public IActionResult Checkout(Orders obj, string payment)
		{
			var order = Provider.Orders.SaveOrder(obj);
			var cart = GetCartFromSession();

			foreach (var item in cart.Items)
			{
				var pro = Provider.Products.GetById(item.ProductId);
				var orderItem = new OrderItems
				{
					OrderId = order.OrderId,
					ProductId = item.ProductId,
					Quantity = item.Quantity,
					Price = pro.Price
				};
				Provider.OrderItems.Create(orderItem);
			}
			if (payment != null)
			{
				string url = _service.ToUrl(order);
				return Redirect(url);
			}
			return Redirect("/cart/success");
		}
		[HttpPost]
		public IActionResult SaveOrder(Orders model)
		{
			var order = Provider.Orders.SaveOrder(model);
			var cart = GetCartFromSession();

			foreach (var item in cart.Items)
			{
				var pro = Provider.Products.GetById(item.ProductId);
				var orderItem = new OrderItems
				{
					OrderId = order.OrderId,
					ProductId = item.ProductId,
					Quantity = item.Quantity,
					Price = pro.Price,
				};
				Provider.OrderItems.Create(orderItem);
			}

			// Redirect vn payment gateway
			string url = _service.ToUrl(order);
			return Redirect(url);
		}


		[HttpGet]
		public IActionResult VnPayReturn(VnPayResponse obj)
		{
			if (obj is null)
			{
				ViewBag.ErrorMessage = "Không nhận được dữ liệu từ VnPay.";
				return View("Error");
			}

			var vnpayLib = new VnPayLibrary();
			vnpayLib.AddResponseData("vnp_Amount", obj.Amount.ToString());
			vnpayLib.AddResponseData("vnp_BankCode", obj.BankCode);
			vnpayLib.AddResponseData("vnp_BankTranNo", obj.BankTranNo);
			vnpayLib.AddResponseData("vnp_CardType", obj.CardType);
			vnpayLib.AddResponseData("vnp_OrderInfo", obj.OrderInfo);
			vnpayLib.AddResponseData("vnp_PayDate", obj.PayDate);
			vnpayLib.AddResponseData("vnp_ResponseCode", obj.ResponseCode);
			vnpayLib.AddResponseData("vnp_TmnCode", obj.TmnCode);
			vnpayLib.AddResponseData("vnp_TransactionNo", obj.TransactionNo);
			vnpayLib.AddResponseData("vnp_TransactionStatus", obj.TransactionStatus);
			vnpayLib.AddResponseData("vnp_TxnRef", obj.TxnRef);
			vnpayLib.AddResponseData("vnp_SecureHash", obj.SecureHash);

			var checkSignature = vnpayLib.ValidateSignature(obj.SecureHash, _vnPayConfig.HashSecret);

			if (!checkSignature)
			{
				ViewBag.ErrorMessage = "Chữ ký không hợp lệ. Vui lòng kiểm tra lại.";
				return View("Error");
			}

			if (obj.ResponseCode == "00" && obj.TransactionStatus == "00")
			{
				var ret = Provider.VnPay.Add(obj);
				if (ret > 0)
				{
					return View("Success");
				}

				ViewBag.ErrorMessage = "Lỗi khi lưu giao dịch vào cơ sở dữ liệu.";
				return View("Error");
			}

			// Thanh toán không thành công. Mã lỗi: vnp_ResponseCode
			ViewBag.ErrorMessage = "Thanh toán không thành công. Mã lỗi: " + obj.ResponseCode;
			ViewBag.DisplayTxnRef = "Mã giao dịch thanh toán: " + obj.OrderInfo;
			ViewBag.DisplayVnpayTranNo = "Mã giao dịch tại VNPAY: " + obj.TransactionNo;
			ViewBag.DisplayAmount = "Số tiền thanh toán (VND): " + obj.Amount;
			ViewBag.DisplayBankCode = "Ngân hàng thanh toán: " + obj.BankCode;
			return View("Error");
		}


		private class VNReturnContent
		{
			public string RspCode { get; set; }
			public string Message { get; set; }
		}
		[HttpGet]
		public IActionResult VnPayIPNReturn(VnPayResponse obj)
		{
			var returnContent = new VNReturnContent();
			if (obj is null)
			{
				returnContent.RspCode = "99";
				returnContent.Message = "Input data required";
				return Ok(returnContent);
			}

			var vnpayLib = new VnPayLibrary();
			vnpayLib.AddResponseData("vnp_Amount", obj.Amount.ToString());
			vnpayLib.AddResponseData("vnp_BankCode", obj.BankCode);
			vnpayLib.AddResponseData("vnp_BankTranNo", obj.BankTranNo);
			vnpayLib.AddResponseData("vnp_CardType", obj.CardType);
			vnpayLib.AddResponseData("vnp_OrderInfo", obj.OrderInfo);
			vnpayLib.AddResponseData("vnp_PayDate", obj.PayDate);
			vnpayLib.AddResponseData("vnp_ResponseCode", obj.ResponseCode);
			vnpayLib.AddResponseData("vnp_TmnCode", obj.TmnCode);
			vnpayLib.AddResponseData("vnp_TransactionNo", obj.TransactionNo);
			vnpayLib.AddResponseData("vnp_TransactionStatus", obj.TransactionStatus);
			vnpayLib.AddResponseData("vnp_TxnRef", obj.TxnRef);
			vnpayLib.AddResponseData("vnp_SecureHash", obj.SecureHash);
			var checkSignature = vnpayLib.ValidateSignature(obj.SecureHash, _vnPayConfig.HashSecret);
			if (!checkSignature)
			{
				returnContent.RspCode = "97";
				returnContent.Message = "Invalid signature";
				return Ok(returnContent);
			}

			var orderId = Convert.ToInt32(obj.TxnRef);
			var order = Provider.Orders.GetById(orderId);
			if (order != null)
			{
				returnContent.RspCode = "01";
				returnContent.Message = "Order not found";
				return Ok(returnContent);
			}

			if (order.TotalAmount != Convert.ToInt32(obj.Amount))
			{
				returnContent.RspCode = "04";
				returnContent.Message = "invalid amount";
				return Ok(returnContent);
			}


			if (order.Status == OrderStatus.Unpaid && obj.ResponseCode == "00" && obj.TransactionStatus == "00")
			{
				//Thanh toan thanh cong
				order.Status = OrderStatus.Paid;
				returnContent.RspCode = "00";
				returnContent.Message = "Confirm Success";
			}
			else
			{
				//Thanh toan khong thanh cong. Ma loi: vnp_ResponseCode
				order.Status = OrderStatus.Error;
				returnContent.RspCode = "02";
				returnContent.Message = "Order already confirmed";
			}
			Provider.Orders.Edit(order);
			return Ok(returnContent);
		}
	}
}
