import 'package:flutter/material.dart';
import 'package:aquora_dashboard_v2/home_page.dart';
import 'package:provider/provider.dart';
import 'package:aquora_dashboard_v2/state/auth_provider.dart';

// --- 1. Définition des Couleurs Spécifiques à votre Design ---
// Couleurs réutilisées
const Color primaryGreen = Color(0xFF8BC34A); // Vert principal (pour le bouton)
const Color primaryBlue = Color(0xFF2199F3); 
const Color mainBackgroundGreen = Color.fromARGB(255, 232, 255, 233); // Le vert clair en fond de la Login Page
const Color cardColor = Colors.white; 


// =======================================================
// === 2. CLASSE CUSTOM CLIPPER (Pour la forme courbée) ===
// =======================================================
class CustomLoginClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // Crée un chemin (Path) pour la forme de la barre
    final path = Path();
    
    // Commence en haut à gauche
    path.lineTo(0, size.height - 50); // Commence plus bas pour la courbe

    // Point de contrôle pour la courbe (en bas et au centre)
    var firstControlPoint = Offset(size.width / 2, size.height - 20); 
    var firstEndPoint = Offset(size.width, size.height - 50); 
    
    // Ajoute la courbe de Bézier quadratique au chemin
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    // Continue jusqu'en haut à droite
    path.lineTo(size.width, 0); 

    // Ferme le chemin
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


// =======================================================
// === 3. WIDGET DE LA PAGE DE CONNEXION (LoginPageV2) ===
// =======================================================


class LoginPageV2 extends StatefulWidget {
  const LoginPageV2({super.key});

  @override
  State<LoginPageV2> createState() => _LoginPageV2State();
}

class _LoginPageV2State extends State<LoginPageV2> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Fonction utilitaire pour créer un champ de texte stylisé
  Widget _buildTextField(String label, TextInputType keyboardType, String hintText, TextEditingController controller, {bool isPassword = false}) {
    return Directionality(
      textDirection: TextDirection.rtl, // Force l'alignement RTL
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelStyle: const TextStyle(color: Colors.black54),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          
          // Style de la bordure du champ
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: primaryGreen, width: 2.0), // Bordure verte au focus
          ),
          // Icône d'œil pour le mot de passe
          suffixIcon: isPassword
              ? const Icon(Icons.visibility_off_outlined, color: Colors.grey)
              : null,
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final auth = Provider.of<AuthProvider>(context);

    // Définit la hauteur de la zone verte supérieure
    final double headerHeight = MediaQuery.of(context).size.height * 0.35; 

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 255, 236), // Fond vert clair général
      
      // L'AppBar est conservée pour le bouton de retour.
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context), 
        ),
        backgroundColor: Colors.transparent, // Rendre la barre transparente
        elevation: 0,
      ),
      
      body: Stack( // Utilisation de Stack pour superposer les éléments
        children: [
          
          // --- 1. La Barre Verte Supérieure Courbée ---
          // Utilise ClipPath pour donner une forme courbée au Container
          ClipPath(
            clipper: CustomLoginClipper(), // Notre forme
            child: Container(
              height: headerHeight, // Hauteur définie
              width: screenWidth,
              color: const Color(0xFF8BC34A), // Le vert de la barre
              child: Center(
                // --- Illustration / Icône ---
                // Le chemin de l'image DOIT être correct dans votre projet (pubspec.yaml)
                child: Image.asset(
                    'assets/illustration.png', // Chemin de votre illustration
                    height: headerHeight * 0.6, // Ajustez la taille de l'image
                    fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // --- 2. Contenu de la Page (Scrollable) ---
          SingleChildScrollView(
            child: Column(
              children: [
                // Espace pour positionner le contenu sous la courbe de la barre verte
                SizedBox(height: headerHeight * 0.7), 
                
                // --- Le Conteneur Blanc de Connexion ---
                Container(
                  width: screenWidth * 0.9, 
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(30.0),
                  
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(25.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.15),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // --- Titre 'مرحبا' ---
                      const Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'مرحبا', 
                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.spa, color: const Color(0xFF8BC34A), size: 28), 
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 40),
                      _buildTextField('البريد الإلكتروني', TextInputType.emailAddress, 'أدخل بريدك الإلكتروني', _emailController),
                      const SizedBox(height: 25),
                      _buildTextField('كلمة المرور', TextInputType.visiblePassword, 'أدخل كلمة المرور', _passwordController, isPassword: true),
                      const SizedBox(height: 50),

                      // --- Bouton de Connexion Principal (Vert) ---
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: auth.isLoading
                              ? null
                              : () async {
                                  await auth.signIn(_emailController.text.trim(), _passwordController.text);
                                  if (auth.error != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(auth.error!)));
                                  } else {
                                    // On success, navigate to Home
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => const HomePage()),
                                    );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryGreen, 
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                            elevation: 0,
                          ),
                          child: auth.isLoading
                              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                              : const Text('سجل الدخول', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white), textDirection: TextDirection.rtl),
                        ),
                      ),
                    ],
                  ),
                ),
                // Espace en bas
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}