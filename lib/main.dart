import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth_screen.dart';
import 'home.dart';
import 'categories.dart';
import 'search.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(WallpaperHub());
}

class WallpaperHub extends StatelessWidget {
  WallpaperHub({super.key});

  // Wallpaper categories with their images
  final Map<String, List<String>> categoryImages = {
    'Nature':
        List.generate(10, (index) => 'assets/images/Nature/n${index + 1}.jpg'),
    'Beach/Mountain':
        List.generate(10, (index) => 'assets/images/Beach/b${index + 1}.jpg'),
    'Portrait': List.generate(
        10, (index) => 'assets/images/Portrait/p${index + 1}.jpg'),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BALOCHIFY',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) =>
            const SplashScreen(), // Ensure SplashScreen is imported
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => HomeScreen(categoryImages: categoryImages),
        '/search': (context) => SearchScreen(categoryImages: categoryImages),
        '/categories': (context) => CategoriesScreen(),
      },
    );
  }
}
