import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      image: 'assets/images/onboarding_doctor.jpg',
      title: 'Kết nối cùng bác sĩ',
      description:
          'Tìm kiếm bác sĩ phù hợp và trao đổi những vấn đề sức khỏe một cách thuận tiện.',
    ),
    OnboardingData(
      image: 'assets/images/onboarding_appointment.jpg',
      title: 'Đặt lịch khám dễ dàng',
      description:
          'Chọn chuyên khoa, bác sĩ và thời gian phù hợp với lịch trình của bạn.',
    ),
    OnboardingData(
      image: 'assets/images/onboarding_records.jpg',
      title: 'Quản lý sức khỏe thông minh',
      description:
          'Lưu trữ và theo dõi thông tin sức khỏe, lịch khám và bệnh án của bạn.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _goToLogin();
    }
  }

  void _skip() {
    _goToLogin();
  }

  void _goToLogin() {
    // TODO: chuyển sang LoginScreen
    //
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => const LoginScreen(),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // =====================================================
            // HÌNH ẢNH - NỬA TRÊN
            // =====================================================
            Expanded(
              flex: 5,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: double.infinity,
                    child: Image.asset(_pages[index].image, fit: BoxFit.cover),
                  );
                },
              ),
            ),

            // =====================================================
            // NỘI DUNG - NỬA DƯỚI
            // =====================================================
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  children: [
                    const SizedBox(height: 28),

                    // =================================================
                    // DOTS
                    // =================================================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_pages.length, (index) {
                        final isActive = index == _currentPage;

                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: isActive ? 22 : 7,
                          height: 7,
                          decoration: BoxDecoration(
                            color: isActive
                                ? const Color(0xFF2563EB)
                                : const Color(0xFFD8E5F2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 25),

                    // =================================================
                    // TITLE
                    // =================================================
                    Text(
                      _pages[_currentPage].title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                        height: 1.25,
                      ),
                    ),

                    const SizedBox(height: 14),

                    // =================================================
                    // DESCRIPTION
                    // =================================================
                    Text(
                      _pages[_currentPage].description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                        height: 1.55,
                      ),
                    ),

                    const Spacer(),

                    // =================================================
                    // BOTTOM BUTTONS
                    // =================================================
                    Row(
                      children: [
                        // BỎ QUA
                        SizedBox(
                          width: 65,
                          child: TextButton(
                            onPressed: _skip,
                            child: const Text(
                              'Bỏ qua',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF64748B),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                        const Spacer(),

                        // TIẾP THEO / BẮT ĐẦU
                        SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _nextPage,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2563EB),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 22,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _currentPage == _pages.length - 1
                                      ? 'Bắt đầu'
                                      : 'Tiếp theo',
                                  style: const TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (_currentPage != _pages.length - 1) ...[
                                  const SizedBox(width: 7),
                                  const Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 18,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// ONBOARDING DATA
// =========================
// R=============================

class OnboardingData {
  final String image;
  final String title;
  final String description;

  OnboardingData({
    required this.image,
    required this.title,
    required this.description,
  });
}
