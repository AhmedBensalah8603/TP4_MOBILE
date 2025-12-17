import 'package:aquora_dashboard_v2/ask.dart';
import 'package:flutter/material.dart';

class AnswerPage extends StatelessWidget {
  const AnswerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 245, 232),

      // ====== APP BAR ======
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
                  Image.asset(
                    'assets/logo.png',
                    width: 45,
                    height: 45,
                  ),

                  Row(
                    children: [
                      _circleIcon(Icons.help_outline),
                      const SizedBox(width: 12),
                      _circleIcon(Icons.home),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // ====== BODY ======
      body: Column(
        children: [
          const SizedBox(height: 20),

          const Text(
            "جاري الإجابة...",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 30),

          // ====== IMAGE DANS UN GRAND CERCLE ======
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/rajel.png', // 👉 mets ton image ici
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          const SizedBox(height: 35),

          // ====== ANIMATION SONORE FICTIVE ======
          const Icon(
            Icons.graphic_eq,
            size: 60,
            color: Colors.black,
          ),

          const SizedBox(height: 30),

          // ====== BOUTONS PAUSE / STOP ======
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Pause
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: IconButton(
                  icon: const Icon(Icons.pause, color: Colors.white, size: 35),
                  onPressed: () {},
                ),
              ),

              const SizedBox(width: 25),

              // Stop
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: IconButton(
                  icon: const Icon(Icons.stop, color: Colors.white, size: 35),
                  onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const Ask()),
                );
              },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===== ICONE CERCLE =====
  static Widget _circleIcon(IconData icon) {
    return Container(
      width: 42,
      height: 42,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFDFF1D6),
      ),
      child: Icon(icon, color: Colors.green, size: 24),
    );
  }
}
