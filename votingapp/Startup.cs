using EasyWebSockets;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using VotingApp.Domain;

namespace VotingApp.Api
{
    public class Startup
    {
        public void ConfigureServices(IServiceCollection services)
        => services.AddSingleton(new Voting())
            .AddEasyWebSockets()
            .AddControllers();

        public void Configure(IApplicationBuilder app)
        => app
            .UseDefaultFiles()
            .UseStaticFiles()
            .UseRouting()
            .UseEndpoints(endpoints => endpoints.MapControllers())
            .UseEasyWebSockets();
    }
}