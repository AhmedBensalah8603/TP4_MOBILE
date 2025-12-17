import 'package:aquora_dashboard_v2/home_page.dart';
import 'package:aquora_dashboard_v2/status_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AquoraApp());
}

/// ===================
/// APP RACINE
/// ===================


/// ===================
/// PAGE AQURO
/// ===================
class AquroPage extends StatelessWidget {
  const AquroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 245, 230),

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
                    width: 80,
                    height: 55,
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFDFF1D6),
                    ),
                    child: Image.asset('assets/logo.png'),
                  ),

                  // ✅ ICONES
                  Row(
                    children: [
                      _iconCircle(Icons.help_outline),
                      const SizedBox(width: 12),

                      // ✅ HOME → AquroPage
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AquoraApp()),
                          );
                        },
                        child: _iconCircle(Icons.home),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "أكورا",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Image.asset(
              'assets/illustration4.png',
              height: 180,
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                children: [
                  Text(
                    "تفاصيل",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "الزراعة المائية تعتبر من الأساليب الحديثة التي تدمج بين تربية الأسماك والزراعة بدون تربة. "
                    "تساعد هذه الطريقة على توفير المياه والحفاظ على البيئة "
                    "وتنتج غذاءً صحياً بطريقة مستدامة.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ✅ BOUTON STATUS
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF8BC34A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StatusPage()),
                  );
                },
                child: const Text(
                  "انتقل إلى الحالة",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ CERCLE ICON
  static Widget _iconCircle(IconData icon) {
    return Container(
      width: 48,
      height: 48,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFDFF1D6),
      ),
      child: Icon(
        icon,
        size: 28,
        color: Colors.green,
      ),
    );
  }
}

/// ===================
/// PAGE STATUS
/// ===================
