import 'package:flutter/material.dart';
import 'package:aquora_dashboard_v2/login_page.dart';// --- 1. Définition des Couleurs Spécifiques à votre Design ---
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'services/api_client.dart';
import 'services/avatar_service.dart';
import 'state/auth_provider.dart';
import 'state/avatar_provider.dart';
const Color primaryGreen = Color(0xFF4CAF50); // Vert principal
const Color lightGreen = Color(0xFFDCE775); // Vert clair
const Color primaryBlue = Color(0xFF2199F3); // Bleu principal légèrement ajusté
const Color lightBlue = Color(0xFF81D4FA); // Bleu clair
const Color backgroundColor = Color(0xFFF1F8E9); // Fond très clair



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Provide AuthProvider and AvatarProvider at the top-level so UI can react to auth state
  final authService = FirebaseAuthService();
  final apiClient = ApiClient();
  final avatarService = AvatarService(apiClient: apiClient, authService: authService);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(authService: authService)),
        ChangeNotifierProvider(create: (_) => AvatarProvider(service: avatarService)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aqura Splash',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Utilisation du vert comme couleur principale du thème
        primarySwatch: Colors.green,
        // Assurez-vous d'avoir une police arabe configurée dans pubspec.yaml si nécessaire
        // Exemple : fontFamily: 'ArabicFont', 
      ),
      home: const WelcomePage(),
      
    );
  }
}

// --- 2. Page d'Accueil (WelcomePage) ---

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  // Fonction utilitaire pour créer un cercle décoratif
  Widget _buildDecorativeCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          // --- 3. Les Cercles Décoratifs en Arrière-plan ---
          // Cercle Vert Supérieur Gauche (partiellement visible)
          Positioned(
            top: -screenHeight * 0.1,
            left: -screenWidth * 0.4,
            child: _buildDecorativeCircle(screenWidth * 0.8, primaryGreen.withOpacity(0.6)),
          ),
          // Cercle Vert Clair Supérieur Droit
          Positioned(
            top: screenHeight * 0.05,
            right: -screenWidth * 0.2,
            child: _buildDecorativeCircle(screenWidth * 0.6, lightGreen.withOpacity(0.7)),
          ),
          // Cercle Bleu Inférieur Droit
          Positioned(
            bottom: -screenHeight * 0.2,
            right: -screenWidth * 0.3,
            child: _buildDecorativeCircle(screenWidth * 0.8, primaryBlue.withOpacity(0.8)),
          ),
          // Cercle Bleu Clair Inférieur Gauche
          Positioned(
            bottom: screenHeight * 0.05,
            left: -screenWidth * 0.2,
            child: _buildDecorativeCircle(screenWidth * 0.5, lightBlue.withOpacity(0.7)),
          ),

          // --- 4. Contenu Principal Centré (Logo et Bouton) ---
          Center(
            child: Column(
              // Utilisation de MainAxisAlignment.center pour centrer verticalement,
              // mais nous ajusterons l'espacement avec SizedBox pour une meilleure
              // ressemblance avec l'image fournie.
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Espace pour ajuster le contenu vers le bas (centrage optique)
                SizedBox(height: screenHeight * 0.3), 

                // --- Logo de l'application ---
                // IMPORTANT : Vous devez remplacer 'assets/logo.png' par le chemin de votre logo
                // qui contient l'icône et le texte 'أكورا'.
                Image.asset(
                  'assets/logo.png', // Chemin à ajuster dans votre projet
                  height: 350, // Taille ajustée pour le centrage
                ),

                // Espace entre le logo et le bouton (ajustez 80.0 si nécessaire)
                const SizedBox(height: 0.00), 

                // --- Bouton de Connexion / Inscription ('سجل الدخول') ---
                Container(
                  width: screenWidth * 0.6, // Largeur du bouton
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.white, // Fond blanc
                    // Bordure très légère et ombre pour un effet 3D subtil
                    border: Border.all(color: Colors.black12, width: 0.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPageV2()), 
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      backgroundColor: Colors.transparent, // Transparence car le fond est géré par le Container
                      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 30.0),
                      side: BorderSide.none, // Supprimer la bordure par défaut
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // La Row est en LTR par défaut. L'icône de flèche est à droite du texte en Arabe.
                      textDirection: TextDirection.rtl, // Force la direction de la ligne (icône à droite)
                      children: const <Widget>[
                        Text(
                          'سجل الدخول', // Se connecter (arabe)
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward_ios, size: 18), // Icône de flèche
                      ],
                    ),
                  ),
                ),
                
                // Espace vide pour maintenir le contenu au centre
                const Spacer(), 
              ],
            ),
          ),
        ],
      ),
    );
  }
}