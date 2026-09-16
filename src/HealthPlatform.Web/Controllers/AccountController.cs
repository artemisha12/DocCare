using Microsoft.AspNetCore.Mvc;
using HealthPlatform.Web.Models;
using HealthPlatform.Web.Services;
using System.Text.Json;

namespace HealthPlatform.Web.Controllers;

public class AccountController : Controller
{
    private readonly HealthApiClient _apiClient;
    private readonly ILogger<AccountController> _logger;

    // Session keys
    private const string SessionKeyUserId   = "UserId";
    private const string SessionKeyFullName = "FullName";
    private const string SessionKeyEmail    = "Email";
    private const string SessionKeyAvatar   = "AvatarUrl";
    private const string SessionKeyRole     = "Role";
    private const string SessionKeyToken    = "AuthToken";

    public AccountController(HealthApiClient apiClient, ILogger<AccountController> logger)
    {
        _apiClient = apiClient;
        _logger = logger;
    }

    // ─── GET /Account/Login ───────────────────────────────────────────────────
    [HttpGet]
    public IActionResult Login(string? returnUrl = null)
    {
        // Nếu đã đăng nhập thì về trang chủ
        if (HttpContext.Session.GetString(SessionKeyUserId) != null)
            return RedirectToAction("Index", "Home");

        ViewData["ReturnUrl"] = returnUrl;
        return View(new LoginViewModel());
    }

    // ─── POST /Account/Login ──────────────────────────────────────────────────
    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Login(LoginViewModel model, string? returnUrl = null)
    {
        ViewData["ReturnUrl"] = returnUrl;

        if (!ModelState.IsValid)
            return View(model);

        var result = await _apiClient.LoginAsync(model);

        if (!result.Success || result.User == null)
        {
            ModelState.AddModelError(string.Empty, result.Message ?? "Đăng nhập thất bại.");
            return View(model);
        }

        // Lưu thông tin vào Session
        HttpContext.Session.SetString(SessionKeyUserId,   result.User.Id);
        HttpContext.Session.SetString(SessionKeyFullName, result.User.FullName);
        HttpContext.Session.SetString(SessionKeyEmail,    result.User.Email);
        HttpContext.Session.SetString(SessionKeyAvatar,   result.User.AvatarUrl ?? "");
        HttpContext.Session.SetString(SessionKeyRole,     result.User.Role);
        HttpContext.Session.SetString(SessionKeyToken,    result.Token ?? "");

        _logger.LogInformation("Người dùng {Email} đã đăng nhập thành công.", result.User.Email);

        if (!string.IsNullOrEmpty(returnUrl) && Url.IsLocalUrl(returnUrl))
            return Redirect(returnUrl);

        return RedirectToAction("Index", "Home");
    }

    // ─── GET /Account/Register ────────────────────────────────────────────────
    [HttpGet]
    public IActionResult Register()
    {
        if (HttpContext.Session.GetString(SessionKeyUserId) != null)
            return RedirectToAction("Index", "Home");

        return View(new RegisterViewModel());
    }

    // ─── POST /Account/Register ───────────────────────────────────────────────
    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Register(RegisterViewModel model)
    {
        if (!ModelState.IsValid)
            return View(model);

        var result = await _apiClient.RegisterAsync(model);

        if (!result.Success)
        {
            ModelState.AddModelError(string.Empty, result.Message ?? "Đăng ký thất bại.");
            return View(model);
        }

        _logger.LogInformation("Tài khoản mới đã được tạo: {Email}", model.Email);

        // Chuyển đến trang đăng nhập kèm thông báo thành công
        TempData["SuccessMessage"] = result.Message ?? "Đăng ký thành công! Vui lòng đăng nhập.";
        return RedirectToAction(nameof(Login));
    }

    // ─── POST /Account/Logout ─────────────────────────────────────────────────
    [HttpPost]
    [ValidateAntiForgeryToken]
    public IActionResult Logout()
    {
        var email = HttpContext.Session.GetString(SessionKeyEmail);
        HttpContext.Session.Clear();
        _logger.LogInformation("Người dùng {Email} đã đăng xuất.", email ?? "unknown");
        return RedirectToAction("Index", "Home");
    }

    // ─── GET /Account/AccessDenied ────────────────────────────────────────────
    [HttpGet]
    public IActionResult AccessDenied()
    {
        return View();
    }
}
