import 'package:aquora_dashboard_v2/AdviceDialog.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:aquora_dashboard_v2/home_page.dart';

class WaterHistoryPage extends StatelessWidget {
  const WaterHistoryPage({super.key});

  // ================= DATA =================
  final List<FlSpot> waterData = const [
    FlSpot(0, 480),
    FlSpot(1, 500),
    FlSpot(2, 470),
    FlSpot(3, 520),
    FlSpot(4, 510),
    FlSpot(5, 480),
    FlSpot(6, 450),
  ];

  // ================= STATE LOGIC =================
  Map<String, dynamic> getState(double value) {
    if (value >= 470 && value <= 520) {
      return {
        "label": "🟢 حالة مريحة",
        "color": Colors.green,
        "desc": "مستوى الماء مناسب للنظام المائي ومستقر."
      };
    } else if ((value >= 440 && value < 470) ||
        (value > 520 && value <= 550)) {
      return {
        "label": "🟡 حالة اضطراب",
        "color": Colors.orange,
        "desc": "مستوى الماء غير مستقر وقد يؤثر على الكفاءة."
      };
    } else {
      return {
        "label": "🔴 حالة خطر",
        "color": Colors.red,
        "desc": "مستوى الماء غير آمن ويتطلب تدخلاً فورياً."
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final lastValue = waterData.last.y;
    final state = getState(lastValue);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 244, 232),

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
              "تاريخ مستوى الماء",
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
                    minY: 400,
                    maxY: 600,

                    // ========= COLORED ZONES =========
                    rangeAnnotations: RangeAnnotations(
                      horizontalRangeAnnotations: [
                        // 🔴 Danger bas
                        HorizontalRangeAnnotation(
                          y1: 400,
                          y2: 440,
                          color: Colors.red.withOpacity(0.25),
                        ),

                        // 🟡 Perturbation
                        HorizontalRangeAnnotation(
                          y1: 440,
                          y2: 470,
                          color: Colors.yellow.withOpacity(0.30),
                        ),

                        // 🟢 Confort
                        HorizontalRangeAnnotation(
                          y1: 470,
                          y2: 520,
                          color: Colors.green.withOpacity(0.25),
                        ),

                        // 🟡 Perturbation
                        HorizontalRangeAnnotation(
                          y1: 520,
                          y2: 550,
                          color: Colors.yellow.withOpacity(0.30),
                        ),

                        // 🔴 Danger haut
                        HorizontalRangeAnnotation(
                          y1: 550,
                          y2: 600,
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
                          interval: 50,
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
                        spots: waterData,
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
                      barrierColor: Colors.black.withOpacity(0.4),
                      builder: (_) => const AdviceDialog(
                        title: "نصائح مستوى الماء",
                        imagePath: "assets/rajel.png", // ✅ نفس avatar de pH
                        adviceText:
                            " عوّض الماء المتبخر بانتظام.\n\n"
                            " نقص الماء قد يؤثر على صحة النظام.",
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
