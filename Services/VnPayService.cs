using System.Net;
using Microsoft.Extensions.Options;
using WebApp.Models;

namespace WebApp.Services;

public class VnPayService
{
	IHttpContextAccessor accessor;
	VnPay vnPay;
	public VnPayService(IOptions<VnPay> options, IHttpContextAccessor accessor)
	{
		this.accessor = accessor;
		vnPay = options.Value;
	}

	public string ToUrl(Orders obj)
	{
		IDictionary<string, string> dict = new SortedDictionary<string, string>
		{
			{"vnp_Version", vnPay.Version},
			{"vnp_Command", vnPay.Command},
			{"vnp_TmnCode", vnPay.TmnCode},
			{"vnp_CurrCode", vnPay.CurrCode},
			{"vnp_Locale", vnPay.Locale},
			{"vnp_OrderType", vnPay.OrderType},
			{"vnp_ReturnUrl", vnPay.ReturnUrl},
            //{"vnp_IpAddr", accessor!.HttpContext!.Connection.RemoteIpAddress!.ToString()},
            {"vnp_IpAddr", "127.0.0.1"},
			{"vnp_Amount", (obj.TotalAmount * 100).ToString("#.")},
			{"vnp_TxnRef", $"{obj.OrderId.ToString()} - {DateTime.Now}" },
			{"vnp_CreateDate", obj.OrderDate.ToString("yyyyMMddHHmmss")},
			{"vnp_OrderInfo", $"Payment for {obj.OrderId} with {obj.TotalAmount.ToString("#.")}"}
		};
		string query = string.Join("&", dict.Select(p => $"{p.Key}={WebUtility.UrlEncode(p.Value)}"));
		string secureHash = Helper.HmacSha512(query, vnPay.HashSecret);
		return $"{vnPay.BaseUrl}?{query}&vnp_SecureHash={secureHash}";
	}
}
