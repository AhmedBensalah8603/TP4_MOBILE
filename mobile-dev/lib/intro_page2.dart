import 'package:aquora_dashboard_v2/intro_page3.dart';
import 'package:flutter/material.dart';

class intro_page2 extends StatelessWidget {
  const intro_page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Spacer(flex: 2),
              
              // Illustration isométrique de la maison intelligente
              Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    'assets/illustration2.png',
                    width: 240,
                    height: 240,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              
              const SizedBox(height: 50),
              
              // Titre principal en arabe
              const Text(
                'تحليل وتحسين ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                  height: 1.3,
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Description en arabe
              const Text(
                '  احصل على رؤى فورية من بيانات و درجة الحرارة والعناصر الغذائية للحفاظ على صحة نظامك البيئي',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF7F8C8D),
                  height: 1.6,
                ),
              ),
              
              const Spacer(flex: 2),
              
              // Bouton "التالي" (Suivant)
              SizedBox(
                
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const intro_page3()),
                            );

                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8BC34A),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'التالي',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}