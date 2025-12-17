import 'package:aquora_dashboard_v2/ask.dart';
import 'package:aquora_dashboard_v2/status_page.dart';
import 'package:aquora_dashboard_v2/system_status_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aquora_dashboard_v2/avatar_chat_page.dart';

// Importer la nouvelle page de statut

// --- Définition des Couleurs du Thème ---
final Color primaryGreen = const Color(0xFF66BB6A);
final Color darkText = const Color(0xFF2E3E5C);
final Color cardColor = Colors.white;
final Color lightBackground = const Color(0xFFF5F7FA);
final Color headerGreen = const Color(0xFF4CAF50); 

void main() {
  runApp(const AquoraApp());
}

class AquoraApp extends StatelessWidget {
  const AquoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aquora Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: GoogleFonts.cairoTextTheme(), 
      ),
      home: const HomePage(), 
    );
  }
}

// =======================================================
// === PAGE DE DÉTAIL GÉNÉRIQUE (Pour 'المراقبة' et 'إسأل أكورا') ===
// =======================================================
class DetailPage extends StatelessWidget {
  final String title;
  final String content;

  const DetailPage({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,
      appBar: AppBar(
        title: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(title, style: GoogleFonts.cairo(fontWeight: FontWeight.bold, color: darkText)),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: darkText),
        elevation: 1,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: darkText,
                height: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// =======================================================
// === TABLEAU DE BORD PRINCIPAL (HomePage) ===
// =======================================================
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedDayIndex = 1;

  final List<Map<String, String>> weekDays = [
    {'day': '14', 'label': 'الخميس'},
    {'day': '13', 'label': 'الأربعاء'},
    {'day': '12', 'label': 'الثلاثاء'},
    {'day': '11', 'label': 'الأثنين'},
    {'day': '10', 'label': 'الأحد'},
  ];
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground, 
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AvatarChatPage()),
        ),
        child: const Icon(Icons.chat_bubble),
        tooltip: 'Open Avatar Chat',
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // --- 1. EN-TÊTE DU HAUT ---
            Container(
              color: headerGreen, 
              padding: const EdgeInsets.only(top: 10.0, bottom: 20.0, left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.water_drop, color: Colors.white, size: 30), 
                      const SizedBox(width: 8),
                      Text(
                        'أكورا', 
                        style: GoogleFonts.cairo(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      _buildHeaderIcon(Icons.help_outline),
                      const SizedBox(width: 10),
                      _buildHeaderIcon(Icons.home),
                    ],
                  ),
                ],
              ),
            ),
            
            // --- 2. SECTION CALENDRIER et Bienvenue ---
            Container(
              color: headerGreen, 
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: lightBackground,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('مرحبا بك', style: GoogleFonts.cairo(fontSize: 26, fontWeight: FontWeight.bold, color: darkText)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('نوفمبر 2025', style: GoogleFonts.cairo(fontSize: 16, color: Colors.grey)),
                        const Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 20),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Calendrier Dynamique
                    SizedBox(
                      height: 90,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: weekDays.length,
                        separatorBuilder: (context, index) => const SizedBox(width: 12),
                        reverse: true,
                        itemBuilder: (context, index) {
                          final isSelected = _selectedDayIndex == index;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedDayIndex = index),
                            child: Container(
                              width: 65,
                              decoration: BoxDecoration(
                                color: isSelected ? primaryGreen : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 3)),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(weekDays[index]['day']!, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isSelected ? Colors.white : darkText)),
                                  Text(weekDays[index]['label']!, style: TextStyle(fontSize: 12, color: isSelected ? Colors.white.withOpacity(0.9) : Colors.grey)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- 3. CONTENU PRINCIPAL (Liste des Cartes) ---
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Titre "Vue d'ensemble"
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text('نظرة عامة', style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.bold, color: darkText)),
                    ),
                    
                    // --- CARTE 1: حالة النظام (NAVIGUE vers SystemStatusPage) ---
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AquroPage()),
                        );
                      },
                      child: _buildWideCard(
                        icon: Icons.thermostat,
                        iconColor: Colors.orange,
                        title: 'حالة النظام',
                        subtitle: 'تحذير بسيط: الحرارة طالعة شوية', 
                        showDot: true, // Ajoutez le point de warning jaune
                      ),
                    ),

                    const SizedBox(height: 15),
                    
                    
                    // --- CARTE 2: المراقبة (NAVIGUE vers DetailPage) ---
                    // --- CARTE 2 : المراقبة (Navigation vers StatusPage) ---
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StatusPage(),
                          ),
                        );
                      },
                      child: _buildWideCard(
                        icon: Icons.show_chart,
                        iconColor: Colors.blue,
                        title: 'المراقبة',
                        subtitle: 'شوف تطور الماء و الحرارة اليوم',
                      ),
                    ),


                    const SizedBox(height: 15),

                    // --- CARTE 3: إرسال أكورا (NAVIGUE vers DetailPage) ---
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Ask()),
                        );
                      },
                      child: _buildWideCard(
                        icon: Icons.chat_bubble,
                        iconColor: primaryGreen,
                        title: 'إسأل أكورا',
                        subtitle: 'شنوة تحب تعرف اليوم؟',
                      ),
                    ),
                    
                      const SizedBox(height: 30),

                    // --- CARTE 4: نصيحة اليوم (Statique) ---
                    _buildTipCard('نصيحة اليوم:', 'زيد شوية ضوء للنباتات'),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      
      // --- 4. BARRE DE NAVIGATION INFÉRIEURE (BottomNavigationBar) ---
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // --- Fonctions de construction de Widgets ---

  Widget _buildHeaderIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2), 
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }

  // Version de la carte large SANS navigation intégrée (utilisée pour الحالة النظام)
  Widget _buildWideCard({
    required IconData icon, 
    required Color iconColor, 
    required String title, 
    required String subtitle,
    bool showDot = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.06), blurRadius: 20, offset: const Offset(0, 5))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Titre et Sous-titre
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                      // Point de statut
                      if (showDot)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: Colors.amber, 
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                      Text(title, style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.bold, color: darkText)), 
                   ],
                ),
                const SizedBox(height: 5),
                Text(subtitle, textAlign: TextAlign.right, style: GoogleFonts.cairo(fontSize: 14, color: Colors.grey[600], height: 1.4)), 
              ],
            ),
          ),
          const SizedBox(width: 15),
          // Icône de la carte
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
            child: Icon(icon, color: iconColor, size: 28),
          ),
        ],
      ),
    );
  }
  
  // Fonction pour les cartes NAVIGABLES vers la DetailPage
  
  // Carte Astuce du jour
  Widget _buildTipCard(String title, String tip) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: primaryGreen.withOpacity(0.1), 
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: primaryGreen.withOpacity(0.3)),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title, 
              style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.bold, color: darkText),
            ),
            const SizedBox(height: 8),
            Text(
              tip, 
              style: GoogleFonts.cairo(fontSize: 15, color: darkText.withOpacity(0.8)),
            ),
          ],
        ),
      ),
    );
  }

  // Barre de navigation inférieure
  Widget _buildBottomNavBar() {
    return Container(
      height: 70, 
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildNavBarItem(Icons.person, isSelected: false),
          _buildNavBarItem(Icons.calendar_today, isSelected: false),
          _buildNavBarItem(Icons.water_drop, isSelected: true), 
          _buildNavBarItem(Icons.notifications_none, isSelected: false),
          _buildNavBarItem(Icons.settings, isSelected: false),
        ],
      ),
    );
  }

  // Élément individuel de la barre de navigation
  Widget _buildNavBarItem(IconData icon, {required bool isSelected}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isSelected ? primaryGreen : Colors.grey[500],
          size: 28,
        ),
        if (isSelected)
          Container(
            margin: const EdgeInsets.only(top: 4),
            height: 4,
            width: 4,
            decoration: BoxDecoration(
              color: primaryGreen,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }
}