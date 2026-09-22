import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFEAF5FD), Color(0xFFF5FAFE), Color(0xFFFFFFFF)],
            stops: [0.0, 0.55, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // =========================
              // LOGO NHỎ
              // =========================
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1976D2).withOpacity(0.08),
                            blurRadius: 15,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.favorite_outline_rounded,
                        size: 24,
                        color: Color(0xFF2463E8),
                      ),
                    ),
                    const SizedBox(width: 11),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Doc',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF111827),
                            ),
                          ),
                          TextSpan(
                            text: 'Care',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2563EB),
                            ),
                          ),
                          TextSpan(
                            text: '•',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF16B8C8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // =========================
              // NỘI DUNG CHÍNH
              // =========================
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // =========================
                      // MINH HỌA
                      // =========================
                      Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.65),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF3B82F6).withOpacity(0.07),
                              blurRadius: 40,
                              spreadRadius: 8,
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Vòng ngoài
                            Container(
                              width: 190,
                              height: 190,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFE8F3FF),
                                border: Border.all(
                                  color: const Color(0xFFD4E8FA),
                                  width: 1,
                                ),
                              ),
                            ),

                            // Icon bác sĩ
                            Container(
                              width: 125,
                              height: 125,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(38),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF2563EB,
                                    ).withOpacity(0.10),
                                    blurRadius: 25,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.medical_services_outlined,
                                size: 62,
                                color: Color(0xFF2563EB),
                              ),
                            ),

                            // Icon trái tim
                            Positioned(
                              right: 27,
                              top: 38,
                              child: _FloatingIcon(
                                icon: Icons.favorite_rounded,
                                color: Color(0xFF16B8C8),
                              ),
                            ),

                            // Icon lịch
                            Positioned(
                              left: 22,
                              bottom: 42,
                              child: _FloatingIcon(
                                icon: Icons.calendar_month_rounded,
                                color: Color(0xFF4C8BF5),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 38),

                      // =========================
                      // TITLE
                      // =========================
                      const Text(
                        'Sức khỏe của bạn,',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF111827),
                          height: 1.2,
                        ),
                      ),

                      const SizedBox(height: 2),

                      const Text(
                        'được kết nối',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2563EB),
                          height: 1.2,
                        ),
                      ),

                      const SizedBox(height: 15),

                      // =========================
                      // DESCRIPTION
                      // =========================
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'Kết nối với bác sĩ, đặt lịch khám và '
                          'quản lý thông tin sức khỏe dễ dàng '
                          'trên một nền tảng.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13.5,
                            color: Color(0xFF64748B),
                            height: 1.55,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),

                      const SizedBox(height: 26),

                      // =========================
                      // FEATURES
                      // =========================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _FeatureItem(
                            icon: Icons.medical_services_outlined,
                            text: 'Bác sĩ',
                          ),
                          const SizedBox(width: 22),
                          _FeatureItem(
                            icon: Icons.calendar_today_outlined,
                            text: 'Đặt lịch',
                          ),
                          const SizedBox(width: 22),
                          _FeatureItem(
                            icon: Icons.folder_outlined,
                            text: 'Bệnh án',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // =========================
              // BOTTOM
              // =========================
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 10, 28, 28),
                child: Column(
                  children: [
                    // Button bắt đầu
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Chuyển sang LoginScreen
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2563EB),
                          foregroundColor: Colors.white,
                          elevation: 5,
                          shadowColor: const Color(
                            0xFF2563EB,
                          ).withOpacity(0.25),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Bắt đầu',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 9),
                            Icon(Icons.arrow_forward_rounded, size: 19),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 17),

                    // Login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Đã có tài khoản? ',
                          style: TextStyle(
                            fontSize: 12.5,
                            color: Color(0xFF64748B),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // TODO: Chuyển sang LoginScreen
                          },
                          child: const Text(
                            'Đăng nhập',
                            style: TextStyle(
                              fontSize: 12.5,
                              color: Color(0xFF2563EB),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'Kết nối sức khỏe, kết nối an tâm',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF94A3B8),
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ======================================================
// FLOATING ICON
// ======================================================

class _FloatingIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _FloatingIcon({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 43,
      height: 43,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Icon(icon, size: 20, color: color),
    );
  }
}

// ======================================================
// FEATURE ITEM
// ======================================================

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeatureItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF3B82F6)),
        const SizedBox(height: 5),
        Text(
          text,
          style: const TextStyle(
            fontSize: 10.5,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
