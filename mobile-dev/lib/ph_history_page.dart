import 'package:aquora_dashboard_v2/AdviceDialog.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:aquora_dashboard_v2/home_page.dart';

class PhHistoryPage extends StatelessWidget {
  const PhHistoryPage({super.key});

  // ================= DATA =================
  final List<FlSpot> phData = const [
    FlSpot(0, 7.1),
    FlSpot(1, 7.3),
    FlSpot(2, 6.9),
    FlSpot(3, 7.4),
    FlSpot(4, 7.0),
    FlSpot(5, 6.8),
    FlSpot(6, 7.2),
  ];

  // ================= STATE LOGIC =================
  Map<String, dynamic> getState(double value) {
    if (value >= 6.5 && value <= 7.5) {
      return {
        "label": "🟢 حالة مريحة",
        "color": Colors.green,
        "desc": "مستوى مثالي لنمو النباتات والأسماك."
      };
    } else if ((value >= 6 && value < 6.5) ||
        (value > 7.5 && value <= 8)) {
      return {
        "label": "🟡 حالة اضطراب",
        "color": Colors.orange,
        "desc": "مستوى pH غير مستقر وقد يؤثر على النظام."
      };
    } else {
      return {
        "label": "🔴 حالة خطر",
        "color": Colors.red,
        "desc": "مستوى pH خطير ويتطلب تدخلاً فورياً."
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final lastPh = phData.last.y;
    final state = getState(lastPh);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 244, 226),

      // ================= APP BAR =================
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
                  _logo(),
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

      // ================= BODY =================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "تاريخ مستوى pH",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // ================= GRAPH =================
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: SizedBox(
                height: 270,
                child: LineChart(
                  LineChartData(
                    minY: 5,
                    maxY: 9,

                    // ========= COLORED ZONES =========
                    rangeAnnotations: RangeAnnotations(
                      horizontalRangeAnnotations: [
                        // 🔴 Danger bas
                        HorizontalRangeAnnotation(
                          y1: 5,
                          y2: 6,
                          color: Colors.red.withOpacity(0.25),
                        ),

                        // 🟡 Perturbation
                        HorizontalRangeAnnotation(
                          y1: 6,
                          y2: 6.5,
                          color: Colors.yellow.withOpacity(0.30),
                        ),

                        // 🟢 Confort
                        HorizontalRangeAnnotation(
                          y1: 6.5,
                          y2: 7.5,
                          color: Colors.green.withOpacity(0.25),
                        ),

                        // 🟡 Perturbation
                        HorizontalRangeAnnotation(
                          y1: 7.5,
                          y2: 8,
                          color: Colors.yellow.withOpacity(0.30),
                        ),

                        // 🔴 Danger haut
                        HorizontalRangeAnnotation(
                          y1: 8,
                          y2: 9,
                          color: Colors.red.withOpacity(0.25),
                        ),
                      ],
                    ),

                    gridData: const FlGridData(show: true),
                    borderData: FlBorderData(show: true),

                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 0.5,
                          reservedSize: 40,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          getTitlesWidget: (v, _) =>
                              Text((v + 1).toInt().toString()),
                        ),
                      ),
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                    ),

                    // ========= LINE =========
                    lineBarsData: [
                      LineChartBarData(
                        spots: phData,
                        isCurved: true,
                        barWidth: 3,
                        color: Colors.black,
                        dotData: const FlDotData(show: true),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ================= STATE CARD =================
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: state["color"].withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: state["color"]),
              ),
              child: Column(
                children: [
                  Text(
                    state["label"],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: state["color"],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state["desc"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, height: 1.4),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ================= BUTTONS =================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ===== زر عودة =====
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context); // يرجع للصفحة السابقة
                  },
                  child: const Text(
                    "← عودة",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                // ===== زر نصائح =====
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierColor: Colors.black.withOpacity(0.4), // خلفية معتمة
                      builder: (_) => const AdviceDialog(
                        title: "نصائح ذكية",
                        adviceText:
                            "تأكد من فحص المضخة بانتظام.\n"
                            "التوازن الجيد يساعد على نمو صحي للنباتات.", imagePath: '',
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "نصائح",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ================= WIDGETS =================
  Widget _logo() => Container(
        width: 48,
        height: 48,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFDFF1D6),
        ),
        padding: const EdgeInsets.all(6),
        child: Image.asset("assets/logo.png"),
      );

  static Widget _circleIcon(IconData icon) => Container(
        width: 42,
        height: 42,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFDFF1D6),
        ),
        child: Icon(icon, color: Colors.green),
      );
}
