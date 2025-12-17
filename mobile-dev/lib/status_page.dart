import 'package:aquora_dashboard_v2/home_page.dart';
import 'package:aquora_dashboard_v2/ph_history_page.dart';
import 'package:aquora_dashboard_v2/water_history_page.dart';
import 'package:aquora_dashboard_v2/temp_history_page.dart';
import 'package:flutter/material.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 244, 223),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png',
              width: 42,
              height: 42,
            ),

            const Spacer(),

            IconButton(
              icon: const Icon(Icons.help_outline, color: Colors.green, size: 26),
              onPressed: () {},
            ),

            IconButton(
              icon: const Icon(Icons.home, color: Colors.green, size: 30),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const AquoraApp()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            StatusCard(
              title: 'مستوى pH',
              value: '7',
              status: 'جيد',
              description: 'تراوحت قيمة pH بين 6.5 و 7.5 وهي مناسبة جداً لنمو النباتات.',
              color: Colors.green,
              onDetailsTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PhHistoryPage()),
                );
              },
            ),

            const SizedBox(height: 22),

            StatusCard(
              title: 'مستوى الماء',
              value: '450 ppm',
              status: 'قابل للتحسن',
              description: 'مستوى الماء غير مستقر وقد يؤثر على الكفاءة. يُنصح بالمراقبة المستمرة.',
              color: Colors.amber,
              onDetailsTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const WaterHistoryPage()),
                );
              },
            ),

            const SizedBox(height: 22),

            StatusCard(
              title: 'درجة الحرارة',
              value: '23°C',
              status: 'جيد',
              description: 'حافظ على درجة الحرارة بين 22°C و 26°C لنمو صحي للنباتات.',
              color: Colors.green,
              onDetailsTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TempHistoryPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class StatusCard extends StatelessWidget {
  final String title;
  final String value;
  final String status;
  final String description;
  final Color color;
  final VoidCallback onDetailsTap;

  const StatusCard({
    super.key,
    required this.title,
    required this.value,
    required this.status,
    required this.description,
    required this.color,
    required this.onDetailsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 8),
              ),
              child: Center(
                child: Text(
                  status,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14, color: Colors.black54, height: 1.5),
                  ),
                  const SizedBox(height: 10),

                  GestureDetector(
                    onTap: onDetailsTap,
                    child: const Text(
                      'تفاصيل',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
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
