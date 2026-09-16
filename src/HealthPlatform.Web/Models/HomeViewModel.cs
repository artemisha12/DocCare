namespace HealthPlatform.Web.Models;

public class HomeViewModel
{
    public List<FeaturedDoctorDto> FeaturedDoctors { get; set; } = new();
    public List<LatestArticleDto> LatestArticles { get; set; } = new();
    public List<ServiceDto> Services { get; set; } = new();
}

public class FeaturedDoctorDto
{
    public int Id { get; set; }
    public string FullName { get; set; } = string.Empty;
    public string Specialty { get; set; } = string.Empty;
    public string Hospital { get; set; } = string.Empty;
    public string AvatarUrl { get; set; } = string.Empty;
    public double Rating { get; set; }
    public int ReviewCount { get; set; }
    public decimal ConsultationFee { get; set; }
    public bool IsOnline { get; set; }
    public string? ExperienceYears { get; set; }
}

public class LatestArticleDto
{
    public int Id { get; set; }
    public string Title { get; set; } = string.Empty;
    public string Excerpt { get; set; } = string.Empty;
    public string Category { get; set; } = string.Empty;
    public string CategoryColor { get; set; } = "blue";
    public string ThumbnailUrl { get; set; } = string.Empty;
    public string Author { get; set; } = string.Empty;
    public int ReadingTimeMinutes { get; set; }
    public DateTime PublishedAt { get; set; }
    public string Slug { get; set; } = string.Empty;
}

public class ServiceDto
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public string IconClass { get; set; } = string.Empty;
    public string Color { get; set; } = string.Empty;
    public string Url { get; set; } = string.Empty;
}
