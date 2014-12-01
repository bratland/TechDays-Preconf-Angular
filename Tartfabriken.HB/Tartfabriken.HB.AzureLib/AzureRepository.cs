using System;
using System.Collections.Generic;
using System.Threading;
using Microsoft.Practices.EnterpriseLibrary.TransientFaultHandling;
using Tartfabriken.HB.Lib.Data;
using Tartfabriken.HB.Lib.Entities;

namespace Tartfabriken.HB.AzureLib
{
	public class AzureRepository
	{
		private readonly string connectionString;
		private readonly RetryPolicy retryPolicy;

		public AzureRepository(string connectionString)
		{
			this.connectionString = connectionString;

			ITransientErrorDetectionStrategy transientErrorDetectionStrategy = new SqlDatabaseTransientErrorDetectionStrategy();
			var exponentialBackoff = new ExponentialBackoff(3, TimeSpan.FromSeconds(2), TimeSpan.FromSeconds(2), TimeSpan.FromSeconds(2))
			{
				FastFirstRetry = true
			};
			retryPolicy = new RetryPolicy(transientErrorDetectionStrategy, exponentialBackoff);
		}

		public IEnumerable<Product> ReadAll()
		{
			List<Product> products;

			using (var reliableSqlConnection = new ReliableSqlConnection(connectionString, retryPolicy))
			{
				reliableSqlConnection.Open();
				var command = reliableSqlConnection.CreateCommand();
				command.CommandText = "SELECT * FROM TartorOchKakor";
				command.ExecuteReaderWithRetry(retryPolicy);
				var reader = command.ExecuteReader();

				products = new List<Product>();

				while (reader.Read())
				{
					var product = new Product
					{
						Id = (int)reader["Id"],
						Name = (string)reader["Name"],
						Description = (string)reader["Description"],
						Price = (decimal)reader["Price"],
						ImageName = (string)reader["ImageName"]
					};
					products.Add(product);
				}
			}

			return products.AsReadOnly();
		}

		public Product GetProductById(int productId)
		{
			Product product;

			using (var reliableSqlConnection = new ReliableSqlConnection(connectionString, retryPolicy))
			{
				reliableSqlConnection.Open();
				var command = reliableSqlConnection.CreateCommand();
				command.CommandText = "SELECT * FROM TartorOchKakor WHERE Id = @productId";
				command.Parameters.AddWithValue("@productId", productId);

				var reader = command.ExecuteReaderWithRetry(retryPolicy);
				reader.Read();

				product = new Product
				{
					Id = (int)reader["Id"],
					Name = (string)reader["Name"],
					Description = (string)reader["Description"],
					Price = (decimal)reader["Price"],
					ImageName = (string)reader["ImageName"]
				};
			}

			return product;
		}

		public void CreateOrder(Order order)
		{
			using (var reliableSqlConnection = new ReliableSqlConnection(connectionString, retryPolicy))
			{
				reliableSqlConnection.Open();

				var sqlCommand = reliableSqlConnection.CreateCommand();

				sqlCommand.CommandText = "INSERT INTO [dbo].[Ordrar] ([Quantity], [ProductId], [Email], [Shipping], [Price]) " +
																 "VALUES(@quantity, @productId, @email, @shipping, @price)";

				sqlCommand.Parameters.AddWithValue("@quantity", order.Quantity);
				sqlCommand.Parameters.AddWithValue("@productId", order.ProductId);
				sqlCommand.Parameters.AddWithValue("@email", order.Email);
				sqlCommand.Parameters.AddWithValue("@shipping", order.Shipping);
				sqlCommand.Parameters.AddWithValue("@price", order.Price);

				sqlCommand.ExecuteScalarWithRetry(retryPolicy);
			}

			Thread.Sleep(TimeSpan.FromSeconds(5));
		}

		public List<Order> OpenOrders()
		{
			return new Repository(connectionString).OpenOrders();
		}

		public void CloseOrder(int orderId)
		{
			new Repository(connectionString).CloseOrder(orderId);
		}
	}
}