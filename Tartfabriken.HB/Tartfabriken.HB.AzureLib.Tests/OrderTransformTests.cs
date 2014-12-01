using Microsoft.VisualStudio.TestTools.UnitTesting;
using Tartfabriken.HB.Lib.Entities;

namespace Tartfabriken.HB.AzureLib.Tests
{
	[TestClass]
	public class OrderTransformTests
	{
		[TestMethod]
		public void Order_Transform()
		{
			var order = new Order
			{
				Id = 42,
				ProductId = 43,
				Email = "email",
				Price = (decimal)4.4,
				Quantity = 45,
				Shipping = "shipping"
			};

			// Test
			string asString = order.AsString();

			Assert.IsNotNull(asString);

			var result = asString.AsOrder();

			Assert.AreEqual(order.Id, result.Id);
			Assert.AreEqual(order.ProductId, result.ProductId);
			Assert.AreEqual(order.Email, result.Email);
			Assert.AreEqual(order.Price, result.Price);
			Assert.AreEqual(order.Quantity, result.Quantity);
			Assert.AreEqual(order.Shipping, result.Shipping);
		}
	}
}
