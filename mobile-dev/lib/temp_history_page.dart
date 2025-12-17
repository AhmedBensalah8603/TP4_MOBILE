import 'package:aquora_dashboard_v2/home_page.dart';
import 'package:aquora_dashboard_v2/AdviceDialog.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TempHistoryPage extends StatelessWidget {
  const TempHistoryPage({super.key});

  // ================= DATA =================
  final List<FlSpot> tempData = const [
    FlSpot(0, 23),
    FlSpot(1, 24.5),
    FlSpot(2, 22),
    FlSpot(3, 25),
    FlSpot(4, 23.5),
    FlSpot(5, 24),
    FlSpot(6, 23),
  ];

  // ================= STATE =================
  Map<String, dynamic> getState(double value) {
    if (value >= 18 && value <= 28) {
      return {
        "label": "🟢 حالة مريحة",
        "color": Colors.green,
        "desc": "درجة الحرارة مثالية لنمو النباتات."
      };
    } else if ((value >= 15 && value < 18) || (value > 28 && value <= 32)) {
      return {
        "label": "🟡 حالة اضطراب",
        "color": Colors.orange,
        "desc": "درجة الحرارة غير مستقرة وقد تؤثر على الإنتاج."
      };
    } else {
      return {
        "label": "🔴 حالة خطر",
        "color": Colors.red,
        "desc": "درجة الحرارة خطيرة وتتطلب تدخلاً فورياً."
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final lastTemp = tempData.last.y;
    final state = getState(lastTemp);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 247, 232),

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
                            MaterialPageRoute(builder: (_) => const AquoraApp()),
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
              "تاريخ درجة الحرارة",
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
                    minY: 10,
                    maxY: 40,

                    // ========= ZONES COLORÉES =========
                    rangeAnnotations: RangeAnnotations(
                      horizontalRangeAnnotations: [
                        // 🔴 DANGER BAS
                        HorizontalRangeAnnotation(
                          y1: 10,
                          y2: 15,
                          color: Colors.red.withOpacity(0.25),
                        ),

                        // 🟡 PERTURBATION BAS
                        HorizontalRangeAnnotation(
                          y1: 15,
                          y2: 18,
                          color: Colors.yellow.withOpacity(0.30),
                        ),

                        // 🟢 CONFORT
                        HorizontalRangeAnnotation(
                          y1: 18,
                          y2: 28,
                          color: Colors.green.withOpacity(0.25),
                        ),

                        // 🟡 PERTURBATION HAUT
                        HorizontalRangeAnnotation(
                          y1: 28,
                          y2: 32,
                          color: Colors.yellow.withOpacity(0.30),
                        ),

                        // 🔴 DANGER HAUT
                        HorizontalRangeAnnotation(
                          y1: 32,
                          y2: 40,
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
                          interval: 5,
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
                        spots: tempData,
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
                      barrierColor: Colors.black.withOpacity(0.4), // نفس الخلفية المعتمة
                      builder: (_) => const AdviceDialog(
                        title: "نصائح درجة الحرارة",
                        adviceText:
                            "تجنب التغيرات المفاجئة في الحرارة.\n"
                            "الحرارة المستقرة تساعد على نمو صحي للنباتات والأسماك.", imagePath: '',
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
