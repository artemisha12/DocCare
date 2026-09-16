using HealthPlatform.Web.Services;

var builder = WebApplication.CreateBuilder(args);

// ── MVC với Razor Views + Session TempData ───────────────────────────────────
builder.Services.AddControllersWithViews()
    .AddSessionStateTempDataProvider();
builder.Services.AddDistributedMemoryCache();
builder.Services.AddSession(options =>
{
    options.IdleTimeout        = TimeSpan.FromHours(8);   // session tồn tại 8 giờ
    options.Cookie.HttpOnly    = true;                    // chống XSS
    options.Cookie.IsEssential = true;                    // GDPR: không cần consent
    options.Cookie.SecurePolicy = Microsoft.AspNetCore.Http.CookieSecurePolicy.SameAsRequest;
    options.Cookie.Name        = ".HealthPlatform.Session";
});

// ── Typed HttpClient cho HealthApiClient ─────────────────────────────────────
builder.Services.AddHttpClient<HealthApiClient>(client =>
{
    var baseUrl = builder.Configuration["ApiSettings:BaseUrl"]
                  ?? "https://localhost:7001/";
    client.BaseAddress = new Uri(baseUrl);
    client.Timeout     = TimeSpan.FromSeconds(30);
    client.DefaultRequestHeaders.Add("Accept", "application/json");
});

// ── HttpContextAccessor (cần để đọc Session từ Service nếu cần sau này) ──────
builder.Services.AddHttpContextAccessor();

var app = builder.Build();

// ── Pipeline ─────────────────────────────────────────────────────────────────
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();

// Session phải đặt TRƯỚC Authorization
app.UseSession();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
