using System.Configuration;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Queue;
using Tartfabriken.HB.Lib.Entities;

namespace Tartfabriken.HB.AzureLib.IntegrationTests
{
	[TestClass]
	public class AzureOrderingServiceTests
	{
		[TestMethod]
		public void Send_Recieve_Order()
		{
			var connectionString = ConfigurationManager.AppSettings[AzureOrderingService.TartQueueConnectionStringConfigurationName];
			var queueName = ConfigurationManager.AppSettings[AzureOrderingService.tartQueueNameConfigurationName];
			var cloudStorageAccount = CloudStorageAccount.Parse(connectionString);
			var cloudQueueClient = new CloudQueueClient(cloudStorageAccount.QueueEndpoint, cloudStorageAccount.Credentials);
			var cloudQueue = cloudQueueClient.GetQueueReference(queueName);

			cloudQueue.CreateIfNotExists();
			cloudQueue.Clear();

			// Pre: No message
			Assert.IsNull(cloudQueue.PeekMessage());

			var azureOrderingService = new AzureOrderingService();

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
			azureOrderingService.Submit(order);

			// Assert: Get the message and compare data.
			CloudQueueMessage cloudQueueMessage = cloudQueue.GetMessage();
			Assert.IsNotNull(cloudQueueMessage);

			Order result = cloudQueueMessage.AsString.AsOrder();
			Assert.IsNotNull(result);

			Assert.AreEqual(order.Id, result.Id);
			Assert.AreEqual(order.ProductId, result.ProductId);
			Assert.AreEqual(order.Email, result.Email);
			Assert.AreEqual(order.Price, result.Price);
			Assert.AreEqual(order.Quantity, result.Quantity);
			Assert.AreEqual(order.Shipping, result.Shipping);
		}
	}
}