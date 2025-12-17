import 'package:aquora_dashboard_v2/home_page.dart';
import 'package:aquora_dashboard_v2/micropage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Ask());
}

/// =======================
/// APP ASK
/// =======================
class Ask extends StatelessWidget {
  const Ask({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AssistantPage(),
    );
  }
}

/// =======================
/// PAGE ASSISTANT
/// =======================
class AssistantPage extends StatelessWidget {
  const AssistantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 237, 226), // vert clair

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
                  // ✅ LOGO
                  Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFDFF1D6),
                    ),
                    padding: const EdgeInsets.all(6),
                    child: Image.asset('assets/logo.png'),
                  ),

                  // ✅ ICONES
                  Row(
                    children: [
                      _circleIcon(Icons.help_outline),
                      const SizedBox(width: 12),

                      // 🏠 MAISON → AquoraApp
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),

      // ===== BODY =====
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "مرحباً، كيف يمكنني مساعدتك؟",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 35),

            // ✅ FARMER
            Container(
              width: 260,
              height: 260,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(20),
              child: Image.asset(
                'assets/farmer.png',
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 45),

            // 🎤 MICRO → NOUVELLE PAGE
            IconButton(
              icon: const Icon(
                Icons.mic,
                size: 55,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const MicroPage()),
                );
              },
            ),
          ],
        ),
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
      child: Icon(
        icon,
        color: Colors.green,
        size: 24,
      ),
    );
  }
}

/// =======================
/// PAGE HOME (AquoraApp)
/// =======================


/// =======================
/// PAGE MICRO
/// =======================
