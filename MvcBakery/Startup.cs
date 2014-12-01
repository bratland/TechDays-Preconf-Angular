using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(MvcBakery.Startup))]
namespace MvcBakery
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            app.MapSignalR(); 
            ConfigureAuth(app);
        }
    }
}
