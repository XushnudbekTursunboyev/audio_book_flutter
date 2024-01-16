import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:audio_book_flutter/data/source/local/pref/my_shared_pref.dart';
import 'package:audio_book_flutter/firebase_options.dart';
import 'package:audio_book_flutter/screens/auth/login/ui/login_screen.dart';
import 'package:audio_book_flutter/screens/auth/register/ui/register_screen.dart';
import 'package:audio_book_flutter/screens/library/ui/library_screen.dart';
import 'package:audio_book_flutter/screens/main/ui/home_screen.dart';
import 'package:audio_book_flutter/screens/main/ui/main_screen.dart';
import 'package:audio_book_flutter/screens/profile/profile_page.dart';
import 'package:audio_book_flutter/screens/search/search_page.dart';
import 'package:audio_book_flutter/screens/splash/ui/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  MySharedPreference.init();

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData.light(useMaterial3: true),
      dark: ThemeData.dark(useMaterial3: true),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            'login': (context) => const LoginScreen(),
            'register': (context) => const RegisterScreen(),
            'main': (context) => const MainScreen(),
            'home': (context) => const HomeScreen(),
            'search': (context) => const SearchPage(),
            'profile': (context) => const ProfilePage(),
            'library': (context) => const LibraryScreen(),
          }),
    );
  }
}
