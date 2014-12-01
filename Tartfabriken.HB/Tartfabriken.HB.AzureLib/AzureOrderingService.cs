using System;
using Microsoft.WindowsAzure;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Queue;
using Microsoft.WindowsAzure.Storage.RetryPolicies;
using Tartfabriken.HB.Lib.Data;
using Tartfabriken.HB.Lib.Entities;

namespace Tartfabriken.HB.AzureLib
{
	public class AzureOrderingService : IOrderingService
	{
		public const string TartQueueConnectionStringConfigurationName = "Tart Queue Connection String";
		public const string tartQueueNameConfigurationName = "Tart Queue Name";

		public bool Submit(Order order)
		{
			var connectionString = EnsureIsConfigured(TartQueueConnectionStringConfigurationName);
			var queueName = EnsureIsConfigured(tartQueueNameConfigurationName);

			var cloudStorageAccount = CloudStorageAccount.Parse(connectionString);
			var cloudQueueClient = new CloudQueueClient(cloudStorageAccount.QueueEndpoint, cloudStorageAccount.Credentials);
			var cloudQueue = cloudQueueClient.GetQueueReference(queueName);

			var retryPolicy = new LinearRetry(TimeSpan.FromSeconds(2), 3);
			var queueRequestOptions = new QueueRequestOptions
			{
				RetryPolicy = retryPolicy
			};

			try
			{
				var orderString = order.AsString();
				var cloudQueueMessage = new CloudQueueMessage(orderString);

				cloudQueue.CreateIfNotExists(queueRequestOptions);
				cloudQueue.AddMessage(cloudQueueMessage, null, null, queueRequestOptions);

				return true;
			}
			// ReSharper disable once EmptyGeneralCatchClause
			catch (Exception exception)
			{
				throw;
			}

			return false;
		}

		private static string EnsureIsConfigured(string key)
		{
			var value = CloudConfigurationManager.GetSetting(key);

			if (string.IsNullOrEmpty(value))
			{
				throw new Exception(string.Format("Expected '{0}' to be configured.", key));
			}

			return value;
		}
	}
}