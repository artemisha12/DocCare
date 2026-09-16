using System.Net.Http.Json;
using System.Text.Json;
using HealthPlatform.Web.Models;

namespace HealthPlatform.Web.Services;

public class HealthApiClient
{
    private readonly HttpClient _httpClient;
    private readonly ILogger<HealthApiClient> _logger;

    // Bật mock để test giao diện khi API chưa sẵn sàng
    // Đặt "UseMock": true trong appsettings.Development.json để test, false khi API sẵn sàng
    private readonly bool _useMock;

    private static readonly JsonSerializerOptions _jsonOptions = new()
    {
        PropertyNameCaseInsensitive = true
    };

    public HealthApiClient(HttpClient httpClient, ILogger<HealthApiClient> logger, IConfiguration configuration)
    {
        _httpClient = httpClient;
        _logger = logger;
        _useMock = configuration.GetValue<bool>("ApiSettings:UseMock", defaultValue: true);
    }

    // ─── AUTH: Login ─────────────────────────────────────────────────────────

    public async Task<AuthResponseDto> LoginAsync(LoginViewModel model)
    {
        if (_useMock)
        {
            await Task.Delay(400); // mô phỏng network latency
            // Mock: tài khoản demo hợp lệ
            if (model.EmailOrPhone == "demo@hellobacsi.vn" && model.Password == "Demo@1234")
            {
                return new AuthResponseDto
                {
                    Success = true,
                    Message = "Đăng nhập thành công.",
                    Token = "mock-jwt-token-abc123",
                    User = new UserInfoDto
                    {
                        Id = "usr-001",
                        FullName = "Nguyễn Văn Demo",
                        Email = "demo@hellobacsi.vn",
                        PhoneNumber = "0912345678",
                        AvatarUrl = "https://randomuser.me/api/portraits/men/32.jpg",
                        Role = "Patient"
                    }
                };
            }
            return new AuthResponseDto { Success = false, Message = "Email/SĐT hoặc mật khẩu không đúng." };
        }

        try
        {
            var payload = new { emailOrPhone = model.EmailOrPhone, password = model.Password, rememberMe = model.RememberMe };
            var response = await _httpClient.PostAsJsonAsync("api/auth/login", payload);
            var result = await response.Content.ReadFromJsonAsync<AuthResponseDto>(_jsonOptions);
            return result ?? new AuthResponseDto { Success = false, Message = "Phản hồi không hợp lệ từ máy chủ." };
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Lỗi khi gọi API đăng nhập.");
            return new AuthResponseDto { Success = false, Message = "Không thể kết nối đến máy chủ. Vui lòng thử lại sau." };
        }
    }

    // ─── AUTH: Register ──────────────────────────────────────────────────────

    public async Task<AuthResponseDto> RegisterAsync(RegisterViewModel model)
    {
        if (_useMock)
        {
            await Task.Delay(500);
            // Mock: email đã tồn tại
            if (model.Email == "existed@hellobacsi.vn")
                return new AuthResponseDto { Success = false, Message = "Email này đã được đăng ký. Vui lòng dùng email khác." };

            return new AuthResponseDto
            {
                Success = true,
                Message = "Đăng ký thành công! Vui lòng đăng nhập để tiếp tục.",
                User = new UserInfoDto
                {
                    Id = "usr-new-001",
                    FullName = model.FullName,
                    Email = model.Email,
                    PhoneNumber = model.PhoneNumber,
                    Role = "Patient"
                }
            };
        }

        try
        {
            var payload = new
            {
                fullName = model.FullName,
                email = model.Email,
                phoneNumber = model.PhoneNumber,
                password = model.Password,
                confirmPassword = model.ConfirmPassword
            };
            var response = await _httpClient.PostAsJsonAsync("api/auth/register", payload);
            var result = await response.Content.ReadFromJsonAsync<AuthResponseDto>(_jsonOptions);
            return result ?? new AuthResponseDto { Success = false, Message = "Phản hồi không hợp lệ từ máy chủ." };
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Lỗi khi gọi API đăng ký.");
            return new AuthResponseDto { Success = false, Message = "Không thể kết nối đến máy chủ. Vui lòng thử lại sau." };
        }
    }

    public async Task<List<FeaturedDoctorDto>> GetFeaturedDoctorsAsync()
    {
        try
        {
            var response = await _httpClient.GetAsync("api/doctors/featured");
            response.EnsureSuccessStatusCode();
            var json = await response.Content.ReadAsStringAsync();
            return JsonSerializer.Deserialize<List<FeaturedDoctorDto>>(json, _jsonOptions)
                   ?? new List<FeaturedDoctorDto>();
        }
        catch (Exception ex)
        {
            _logger.LogWarning(ex, "Không thể lấy danh sách bác sĩ nổi bật, dùng dữ liệu mẫu.");
            return GetFallbackDoctors();
        }
    }

    public async Task<List<LatestArticleDto>> GetLatestArticlesAsync()
    {
        try
        {
            var response = await _httpClient.GetAsync("api/articles/latest");
            response.EnsureSuccessStatusCode();
            var json = await response.Content.ReadAsStringAsync();
            return JsonSerializer.Deserialize<List<LatestArticleDto>>(json, _jsonOptions)
                   ?? new List<LatestArticleDto>();
        }
        catch (Exception ex)
        {
            _logger.LogWarning(ex, "Không thể lấy bài viết mới nhất, dùng dữ liệu mẫu.");
            return GetFallbackArticles();
        }
    }

    public async Task<List<ServiceDto>> GetServicesAsync()
    {
        try
        {
            var response = await _httpClient.GetAsync("api/services");
            response.EnsureSuccessStatusCode();
            var json = await response.Content.ReadAsStringAsync();
            return JsonSerializer.Deserialize<List<ServiceDto>>(json, _jsonOptions)
                   ?? new List<ServiceDto>();
        }
        catch (Exception ex)
        {
            _logger.LogWarning(ex, "Không thể lấy danh sách dịch vụ, dùng dữ liệu mẫu.");
            return GetFallbackServices();
        }
    }

    // ─── Fallback data (dùng khi API chưa sẵn sàng) ─────────────────────────

    private static List<FeaturedDoctorDto> GetFallbackDoctors() =>
    [
        new() {
            Id = 1, FullName = "TS.BS Nguyễn Văn An", Specialty = "Tim mạch",
            Hospital = "BV Bạch Mai", AvatarUrl = "https://randomuser.me/api/portraits/men/32.jpg",
            Rating = 4.9, ReviewCount = 328, ConsultationFee = 300000, IsOnline = true, ExperienceYears = "15 năm"
        },
        new() {
            Id = 2, FullName = "PGS.TS Trần Thị Bình", Specialty = "Nhi khoa",
            Hospital = "BV Nhi Trung Ương", AvatarUrl = "https://randomuser.me/api/portraits/women/44.jpg",
            Rating = 4.8, ReviewCount = 512, ConsultationFee = 250000, IsOnline = true, ExperienceYears = "20 năm"
        },
        new() {
            Id = 3, FullName = "BS.CKI Lê Minh Tuấn", Specialty = "Da liễu",
            Hospital = "BV Da liễu TW", AvatarUrl = "https://randomuser.me/api/portraits/men/56.jpg",
            Rating = 4.7, ReviewCount = 189, ConsultationFee = 200000, IsOnline = false, ExperienceYears = "10 năm"
        },
        new() {
            Id = 4, FullName = "ThS.BS Phạm Thu Hà", Specialty = "Sản phụ khoa",
            Hospital = "BV Phụ sản HN", AvatarUrl = "https://randomuser.me/api/portraits/women/68.jpg",
            Rating = 4.9, ReviewCount = 401, ConsultationFee = 350000, IsOnline = true, ExperienceYears = "12 năm"
        },
    ];

    private static List<LatestArticleDto> GetFallbackArticles() =>
    [
        new() {
            Id = 1, Title = "10 thực phẩm giúp tăng cường hệ miễn dịch hiệu quả",
            Excerpt = "Chế độ ăn uống đúng cách có thể giúp cơ thể chống lại bệnh tật một cách tự nhiên.",
            Category = "Dinh dưỡng", CategoryColor = "green",
            ThumbnailUrl = "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=600",
            Author = "BS. Nguyễn Hương", ReadingTimeMinutes = 5,
            PublishedAt = DateTime.Now.AddDays(-2), Slug = "thuc-pham-tang-mien-dich"
        },
        new() {
            Id = 2, Title = "Cách kiểm soát đường huyết cho người tiểu đường type 2",
            Excerpt = "Những phương pháp khoa học và thực tiễn giúp duy trì chỉ số đường huyết ổn định.",
            Category = "Bệnh mãn tính", CategoryColor = "red",
            ThumbnailUrl = "https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=600",
            Author = "TS.BS Lê Văn Khoa", ReadingTimeMinutes = 7,
            PublishedAt = DateTime.Now.AddDays(-4), Slug = "kiem-soat-duong-huyet"
        },
        new() {
            Id = 3, Title = "Bài tập yoga buổi sáng giúp giảm stress hiệu quả",
            Excerpt = "Chỉ 15 phút yoga mỗi sáng có thể cải thiện đáng kể sức khỏe tinh thần và thể chất.",
            Category = "Tập luyện", CategoryColor = "purple",
            ThumbnailUrl = "https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=600",
            Author = "HLV Minh Châu", ReadingTimeMinutes = 4,
            PublishedAt = DateTime.Now.AddDays(-6), Slug = "yoga-buoi-sang-giam-stress"
        },
    ];

    private static List<ServiceDto> GetFallbackServices() =>
    [
        new() {
            Id = 1, Name = "Đặt lịch khám", Description = "Đặt lịch khám với hơn 500+ bác sĩ chuyên khoa",
            IconClass = "fa-calendar-check", Color = "blue", Url = "/booking"
        },
        new() {
            Id = 2, Name = "Tư vấn trực tuyến", Description = "Chat/Video call với bác sĩ mọi lúc, mọi nơi",
            IconClass = "fa-video", Color = "green", Url = "/consultation"
        },
        new() {
            Id = 3, Name = "Sức khỏe của tôi", Description = "Theo dõi hồ sơ và chỉ số sức khỏe cá nhân",
            IconClass = "fa-heartbeat", Color = "red", Url = "/health-records"
        },
        new() {
            Id = 4, Name = "Nhà thuốc trực tuyến", Description = "Mua thuốc theo đơn, giao hàng tận nơi",
            IconClass = "fa-pills", Color = "orange", Url = "/pharmacy"
        },
    ];
}
