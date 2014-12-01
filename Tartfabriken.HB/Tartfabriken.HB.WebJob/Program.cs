using System;
using System.Configuration;
using Microsoft.WindowsAzure;
using Microsoft.WindowsAzure.Jobs;
using Tartfabriken.HB.AzureLib;
using Tartfabriken.HB.Lib;
using Tartfabriken.HB.Lib.Data;
using Tartfabriken.HB.Lib.Entities;

namespace Tartfabriken.HB.WebJob
{
	class Program
	{
		static string smtpServer;
		static int port;
		static bool enableSsl;
		static string userName, passWord;
		static string fromEmail, fromName;
		static string subject;
		private static string connectionString;

		static void Main()
		{
			#region Get AppSettings
			smtpServer = ConfigurationManager.AppSettings["Tartmail smtp server"];
			port = Convert.ToInt32(ConfigurationManager.AppSettings["Tartmail port"]);
			enableSsl = Convert.ToBoolean(ConfigurationManager.AppSettings["Tartmail enable SSL"]);
			userName = ConfigurationManager.AppSettings["Tartmail user name"];
			passWord = ConfigurationManager.AppSettings["Tartmail password"];
			fromEmail = ConfigurationManager.AppSettings["Tartmail from email"];
			fromName = ConfigurationManager.AppSettings["Tartmail from name"];
			subject = ConfigurationManager.AppSettings["Tartmail subject line"];
			connectionString = ConfigurationManager.ConnectionStrings["tartfabriken"].ConnectionString;
			#endregion

			var jobHost = new JobHost();
			jobHost.RunAndBlock();
		}

		// ReSharper disable once UnusedMember.Global
		public static void ProcessTartOrder([QueueInput("tartorders")] Order order)
		{
			var repository = new AzureRepository(connectionString);

			Product product = repository.GetProductById(order.ProductId);

			// Takes a while - WITH retries!
			repository.CreateOrder(order);

			// Takes a while 2
			var webMail = new WebMail();
			var tartMailService = new TartMailService();
			var emailBody = tartMailService.CreateMailBodyFor(order, product);
			webMail.Send(smtpServer, port, enableSsl, userName, passWord, fromEmail, fromName, order.Email, subject, emailBody);
		}
	}
}