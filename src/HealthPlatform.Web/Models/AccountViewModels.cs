using System.ComponentModel.DataAnnotations;

namespace HealthPlatform.Web.Models;

// ─── Response DTO từ API ──────────────────────────────────────────────────────

public class AuthResponseDto
{
    public bool Success { get; set; }
    public string? Message { get; set; }
    public string? Token { get; set; }
    public string? RefreshToken { get; set; }
    public UserInfoDto? User { get; set; }
}

public class UserInfoDto
{
    public string Id { get; set; } = string.Empty;
    public string FullName { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string? PhoneNumber { get; set; }
    public string? AvatarUrl { get; set; }
    public string Role { get; set; } = "Patient";
}

// ─── Login ViewModel ──────────────────────────────────────────────────────────

public class LoginViewModel
{
    [Required(ErrorMessage = "Vui lòng nhập email hoặc số điện thoại.")]
    [Display(Name = "Email / Số điện thoại")]
    public string EmailOrPhone { get; set; } = string.Empty;

    [Required(ErrorMessage = "Vui lòng nhập mật khẩu.")]
    [DataType(DataType.Password)]
    [Display(Name = "Mật khẩu")]
    public string Password { get; set; } = string.Empty;

    [Display(Name = "Ghi nhớ đăng nhập")]
    public bool RememberMe { get; set; }
}

// ─── Register ViewModel ───────────────────────────────────────────────────────

public class RegisterViewModel
{
    [Required(ErrorMessage = "Vui lòng nhập họ và tên.")]
    [StringLength(100, MinimumLength = 2, ErrorMessage = "Họ và tên phải từ 2 đến 100 ký tự.")]
    [Display(Name = "Họ và tên")]
    public string FullName { get; set; } = string.Empty;

    [Required(ErrorMessage = "Vui lòng nhập địa chỉ email.")]
    [EmailAddress(ErrorMessage = "Địa chỉ email không hợp lệ.")]
    [Display(Name = "Email")]
    public string Email { get; set; } = string.Empty;

    [Required(ErrorMessage = "Vui lòng nhập số điện thoại.")]
    [Phone(ErrorMessage = "Số điện thoại không hợp lệ.")]
    [RegularExpression(@"^(0|\+84)[3|5|7|8|9][0-9]{8}$",
        ErrorMessage = "Số điện thoại Việt Nam không hợp lệ (VD: 0912345678).")]
    [Display(Name = "Số điện thoại")]
    public string PhoneNumber { get; set; } = string.Empty;

    [Required(ErrorMessage = "Vui lòng nhập mật khẩu.")]
    [StringLength(100, MinimumLength = 8, ErrorMessage = "Mật khẩu phải có ít nhất 8 ký tự.")]
    [DataType(DataType.Password)]
    [Display(Name = "Mật khẩu")]
    public string Password { get; set; } = string.Empty;

    [Required(ErrorMessage = "Vui lòng xác nhận mật khẩu.")]
    [DataType(DataType.Password)]
    [Compare("Password", ErrorMessage = "Mật khẩu xác nhận không khớp.")]
    [Display(Name = "Xác nhận mật khẩu")]
    public string ConfirmPassword { get; set; } = string.Empty;

    [Range(typeof(bool), "true", "true",
        ErrorMessage = "Bạn phải đồng ý với Điều khoản & Chính sách bảo mật.")]
    [Display(Name = "Tôi đồng ý với Điều khoản & Chính sách bảo mật")]
    public bool AgreeTerms { get; set; }
}
