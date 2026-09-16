using Microsoft.AspNetCore.Mvc;
using HealthPlatform.Web.Models;
using HealthPlatform.Web.Services;

namespace HealthPlatform.Web.Controllers;

public class HomeController : Controller
{
    private readonly HealthApiClient _apiClient;
    private readonly ILogger<HomeController> _logger;

    public HomeController(HealthApiClient apiClient, ILogger<HomeController> logger)
    {
        _apiClient = apiClient;
        _logger = logger;
    }

    public async Task<IActionResult> Index()
    {
        // Gọi song song cả 3 API để giảm latency
        var doctorsTask  = _apiClient.GetFeaturedDoctorsAsync();
        var articlesTask = _apiClient.GetLatestArticlesAsync();
        var servicesTask = _apiClient.GetServicesAsync();

        await Task.WhenAll(doctorsTask, articlesTask, servicesTask);

        var viewModel = new HomeViewModel
        {
            FeaturedDoctors = await doctorsTask,
            LatestArticles  = await articlesTask,
            Services        = await servicesTask
        };

        return View(viewModel);
    }
}
