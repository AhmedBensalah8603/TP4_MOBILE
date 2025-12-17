import 'package:aquora_dashboard_v2/answer_page.dart';
import 'package:aquora_dashboard_v2/home_page.dart';
import 'package:flutter/material.dart';

class MicroPage extends StatelessWidget {
  const MicroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 247, 235), // vert clair

      // ===== APP BAR =====
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo
                  Image.asset(
                    'assets/logo.png',
                    width: 90,
                    height: 90,
                  ),

                  // Icônes
                  Row(
                    children: [
                      _circleIcon(Icons.help_outline),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const AquoraApp()),
                            (route) => false,
                          );
                        },
                        child: _circleIcon(Icons.home),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // ===== BODY =====
      body: Column(
        children: [
          const SizedBox(height: 20),

          // ✅ TEXTE
          const Text(
            "جاري الاستماع...",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          // ✅ CENTRAGE TOTAL
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ✅ GRAND CERCLE
                  Container(
                    width: 250,
                    height: 250,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.hearing,
                        size: 120,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // ✅ BOUTON STOP
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.stop,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const AnswerPage()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===== Widget icône cercle =====
  static Widget _circleIcon(IconData icon) {
    return Container(
      width: 42,
      height: 42,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFDFF1D6),
      ),
      child: Icon(
        icon,
        color: Colors.green,
        size: 24,
      ),
    );
  }
}
