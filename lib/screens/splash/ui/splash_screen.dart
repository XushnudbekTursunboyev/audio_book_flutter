import 'package:app_popup_menu/app_popup_menu.dart';
import 'package:audio_book_flutter/data/source/local/pref/my_shared_pref.dart';
import 'package:audio_book_flutter/screens/auth/register/ui/register_screen.dart';
import 'package:audio_book_flutter/screens/components/button_get_started.dart';
import 'package:audio_book_flutter/screens/main/ui/home_screen.dart';
import 'package:audio_book_flutter/screens/splash/bloc/splash_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => SplashBloc(),
  child: Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xFFE4E4E4)),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 100),
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/back_splash.png'), fit: BoxFit.fill)),
              child: Image.asset('assets/images/logo_back.png'),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              height: 411,
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.only(bottom: 50, right: 69),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/gifs/phone.gif",),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Color(0xFFE4E4E4), BlendMode.color)
                ),
                color: Color(0xFFE4E4E4)
              ),
              // decoration: BoxDecoration(
              //     image: DecorationImage(
              //         image: AssetImage('assets/images/book.png'))),
              child: BlocConsumer<SplashBloc, SplashState>(
                listener: (context, state) {
                  if (state is ClickState) {
                    print("isRegistered ${MySharedPreference.isRegister()}");
                    if (MySharedPreference.isRegister() == true) {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0);
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => RegisterScreen(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0);
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                        ),
                      );
                    }
                  }
                },
                builder: (context, state) {
                  return getStartedButton(() {
                    context.read<SplashBloc>().add(ClickEvent());
                  });
                },
              ),
            )
          ],
        ),
      ),
    ),
);
  }
}
