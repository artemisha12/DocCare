import 'package:flutter/material.dart';

// Model dữ liệu cho từng trang Onboarding
class OnboardingData {
  final String title;
  final String description;
  final IconData icon;
  final Color primaryColor;
  final Color cardBgColor;

  OnboardingData({
    required this.title,
    required this.description,
    required this.icon,
    required this.primaryColor,
    required this.cardBgColor,
  });
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  // Dữ liệu 3 trang Onboarding chuẩn chủ đề y tế DocCare (Tone Xanh)
  final List<OnboardingData> _pages = [
    OnboardingData(
      title: 'Track Your Health',
      description:
          'Theo dõi chỉ số sức khỏe hàng ngày và quản lý hồ sơ y tế thông minh, tiện lợi.',
      icon: Icons.monitor_heart_rounded,
      primaryColor: const Color(0xFF2563EB),
      cardBgColor: const Color(0xFFEFF6FF),
    ),
    OnboardingData(
      title: 'Plan Consultations',
      description:
          'Đặt lịch khám linh hoạt với đội ngũ bác sĩ chuyên khoa chất lượng cao mọi lúc.',
      icon: Icons.calendar_month_rounded,
      primaryColor: const Color(0xFF0284C7),
      cardBgColor: const Color(0xFFE0F2FE),
    ),
    OnboardingData(
      title: 'Daily Care Insights',
      description:
          'Nhận tư vấn dinh dưỡng, nhắc lịch uống thuốc và lời khuyên chăm sóc sức khỏe.',
      icon: Icons.health_and_safety_rounded,
      primaryColor: const Color(0xFF0D9488),
      cardBgColor: const Color(0xFFCCFBF1),
    ),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _nextPage() {
    if (_currentIndex < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Điều hướng chuyển trang khi hoàn thành 3 trang Onboarding
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // =========================
            // PAGE VIEW MAIN CONTENT
            // =========================
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Column(
                    children: [
                      const SizedBox(height: 12),

                      // 1. Khung minh họa dạng Thẻ Cong Tự Nhiên (Top Curved Card UI)
                      Expanded(
                        flex: 6,
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: page.cardBgColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(36),
                              topRight: Radius.circular(36),
                              bottomLeft: Radius.circular(100),
                              bottomRight: Radius.circular(100),
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Đường nhịp tim chìm phía sau
                              Positioned(
                                left: 0,
                                right: 0,
                                top: 120,
                                child: Opacity(
                                  opacity: 0.15,
                                  child: CustomPaint(
                                    size: const Size(120, 45),
                                    painter: HeartbeatPainter(),
                                  ),
                                ),
                              ),

                              // Vòng tròn trung tâm
                              Container(
                                width: 140,
                                height: 140,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.85),
                                ),
                              ),

                              // Icon chính
                              Icon(
                                page.icon,
                                size: 75,
                                color: page.primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // 2. Nội dung Tiêu đề & Mô tả
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 36),
                          child: Column(
                            children: [
                              Text(
                                page.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E293B),
                                  letterSpacing: -0.4,
                                ),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                page.description,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 13.5,
                                  color: Color(0xFF64748B),
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // =========================
            // FOOTER: Controls & Indicators
            // =========================
            Padding(
              padding: const EdgeInsets.only(
                left: 28,
                right: 28,
                bottom: 24,
                top: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Nút PREV / SKIP
                  SizedBox(
                    width: 80,
                    child: _currentIndex > 0
                        ? TextButton(
                            onPressed: _previousPage,
                            style: TextButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.zero,
                            ),
                            child: const Text(
                              'PREV',
                              style: TextStyle(
                                color: Color(0xFF94A3B8),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          )
                        : TextButton(
                            onPressed: () {
                              _pageController.jumpToPage(_pages.length - 1);
                            },
                            style: TextButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.zero,
                            ),
                            child: const Text(
                              'SKIP',
                              style: TextStyle(
                                color: Color(0xFF94A3B8),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                  ),

                  // Dots Indicator
                  Row(
                    children: List.generate(
                      _pages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 3.5),
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index
                              ? const Color(0xFF2563EB)
                              : const Color(0xFFCBD5E1),
                        ),
                      ),
                    ),
                  ),

                  // Nút NEXT / GET STARTED
                  SizedBox(
                    width: 90,
                    child: TextButton(
                      onPressed: _nextPage,
                      style: TextButton.styleFrom(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        _currentIndex == _pages.length - 1
                            ? 'GET STARTED'
                            : 'NEXT',
                        style: TextStyle(
                          color: _currentIndex == _pages.length - 1
                              ? const Color(0xFF0D9488)
                              : const Color(0xFF2563EB),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// CustomPainter Vẽ đường nhịp tim
// ======================================================
class HeartbeatPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF3B82F6)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path = Path();

    path.moveTo(0, size.height * 0.55);
    path.lineTo(20, size.height * 0.55);

    path.lineTo(27, size.height * 0.55);
    path.lineTo(31, size.height * 0.30);
    path.lineTo(35, size.height * 0.75);
    path.lineTo(40, size.height * 0.55);

    path.lineTo(65, size.height * 0.55);

    path.lineTo(70, size.height * 0.55);
    path.lineTo(74, size.height * 0.25);
    path.lineTo(79, size.height * 0.78);
    path.lineTo(84, size.height * 0.55);

    path.lineTo(size.width, size.height * 0.55);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}