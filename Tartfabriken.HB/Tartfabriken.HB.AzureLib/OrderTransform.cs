using System;
using System.Text;
using AutoMapper;
using Newtonsoft.Json;
using Tartfabriken.HB.Lib.Entities;

namespace Tartfabriken.HB.AzureLib
{
	public static class OrderTransform
	{
		static OrderTransform()
		{
			Mapper.CreateMap<Order, OrderData>();
			Mapper.CreateMap<OrderData, Order>();
		}

		public static string AsString(this Order order)
		{
			OrderData orderData = Mapper.Map<Order, OrderData>(order);
			//orderData.Email = EncodeTo64(orderData.Email);
			//orderData.Shipping = EncodeTo64(orderData.Shipping);
			return JsonConvert.SerializeObject(orderData);
		}

		public static Order AsOrder(this string orderString)
		{
			var orderData = JsonConvert.DeserializeObject<OrderData>(orderString);
			//orderData.Email = DecodeFrom64(orderData.Email);
			//orderData.Shipping = DecodeFrom64(orderData.Shipping);
			return Mapper.Map<OrderData, Order>(orderData);
		}

		private static string EncodeTo64(string toEncode)
		{
			byte[] toEncodeAsBytes = Encoding.ASCII.GetBytes(toEncode);
			string returnValue= Convert.ToBase64String(toEncodeAsBytes);
			return returnValue;
		}
		static public string DecodeFrom64(string encodedData)
		{
			byte[] encodedDataAsBytes = Convert.FromBase64String(encodedData);
			string returnValue = Encoding.ASCII.GetString(encodedDataAsBytes);
			return returnValue;
		}

		// ReSharper disable once ClassNeverInstantiated.Local
		// ReSharper disable UnusedMember.Local
		private class OrderData
		{
			public int Id { get; set; }
			public int ProductId { get; set; }
			public string Email { get; set; }
			public string Shipping { get; set; }
			public int Quantity { get; set; }
			public decimal Price { get; set; }
		}
		// ReSharper restore UnusedMember.Local
	}
}