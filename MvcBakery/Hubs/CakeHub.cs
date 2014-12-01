using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;
using MvcBakery.Models;

namespace MvcBakery.Hubs
{
    public class CakeHub : Hub
    {
        public void AddOrder(Order order)
        {
            var db = new TartfabrikenEntities();
            db.Orders.Add(order);
            db.SaveChanges();
            Clients.All.addOrder(order);
        }
    }
}