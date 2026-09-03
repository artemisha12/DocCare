import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        // Ombre xanh trắng nhẹ giống ảnh mẫu
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE5F1FC),
              Color(0xFFEDF6FD),
              Color(0xFFF6FAFE),
              Color(0xFFFFFFFF),
            ],
            stops: [0.0, 0.30, 0.65, 1.0],
          ),
        ),

        child: SafeArea(
          child: Stack(
            children: [
              // Hiệu ứng đường nhịp tim rất nhẹ phía dưới
              Positioned(
                left: -10,
                top: MediaQuery.of(context).size.height * 0.48,
                child: Opacity(
                  opacity: 0.12,
                  child: CustomPaint(
                    size: const Size(120, 45),
                    painter: HeartbeatPainter(),
                  ),
                ),
              ),

              // Nội dung chính
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // =========================
                    // LOGO
                    // =========================
                    Container(
                      width: 86,
                      height: 86,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1976D2).withOpacity(0.10),
                            blurRadius: 25,
                            spreadRadius: 2,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.favorite_outline_rounded,
                          size: 48,
                          color: Color(0xFF2463E8),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // =========================
                    // TÊN APP
                    // =========================
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Doc',
                            style: TextStyle(
                              fontSize: 29,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF111827),
                              letterSpacing: -0.8,
                            ),
                          ),
                          TextSpan(
                            text: 'Care',
                            style: TextStyle(
                              fontSize: 29,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2563EB),
                              letterSpacing: -0.8,
                            ),
                          ),
                          TextSpan(
                            text: '•',
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF16B8C8),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 5),

                    // =========================
                    // SLOGAN
                    // =========================
                    const Text(
                      'Chăm sóc sức khỏe thông minh & tận tâm',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // =========================
                    // BADGE
                    // =========================
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.72),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFFD7E7F8),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.025),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF19C88A),
                            ),
                          ),
                          const SizedBox(width: 7),
                          const Text(
                            'Hệ sinh thái Bác sĩ & Bệnh án số',
                            style: TextStyle(
                              fontSize: 10.5,
                              color: Color(0xFF2563EB),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // =========================
              // FOOTER
              // =========================
              Positioned(
                bottom: 41,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    // Thanh tiến trình
                    Container(
                      width: 90,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCE8F5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 27,
                          height: 4,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2563EB),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 13),

                    const Text(
                      'Phiên bản 2.4.0   •   Tiêu chuẩn Y tế Quốc tế',
                      style: TextStyle(
                        fontSize: 9.5,
                        color: Color(0xFF718096),
                        letterSpacing: 0.1,
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
// Vẽ đường nhịp tim nhẹ
// ======================================================

class HeartbeatPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF3B82F6)
      ..strokeWidth = 1.2
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
