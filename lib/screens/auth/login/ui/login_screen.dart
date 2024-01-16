import 'package:audio_book_flutter/data/source/local/pref/my_shared_pref.dart';
import 'package:audio_book_flutter/data/source/local/pref/my_shared_pref.dart';
import 'package:audio_book_flutter/screens/auth/login/bloc/login_bloc.dart';
import 'package:audio_book_flutter/screens/components/auth_button.dart';
import 'package:audio_book_flutter/screens/components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var _controllerEmail = TextEditingController();
  var _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const Color customColor = Color(0xFFF26B6C);

    return BlocProvider(
      create: (_) => LoginBloc(),
      child:  BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is ClickRegisterState) {
            Navigator.pop(context);
          }
          if (state is ClickBackState) {
            Navigator.pop(context);
          }
          if (state is SuccessSignInState) {
            MySharedPreference.setRegister(true);
            Navigator.pushNamedAndRemoveUntil(
                context, "home", (context) => false);
          }
          if (state is FailureSignInState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.msg),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        Image.asset('assets/images/back_splash.png'),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding:
                            const EdgeInsets.only(left: 33, top: 55, right: 33),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    context.read<LoginBloc>().add(ClickBackEvent());
                                  },
                                  child: const FittedBox(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.arrow_back,
                                            color: Color(0xFF787878),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            'Go Back',
                                            style: TextStyle(
                                              color: Color(0xFF787878),
                                              fontSize: 20,
                                              fontFamily: 'Uni Neue',
                                              fontWeight: FontWeight.w900,
                                              height: 0,
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 67),
                                  child: Image.asset(
                                    "assets/images/head_book.png",
                                    height: 100,
                                    width: 108,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 15),
                                  child: Text(
                                    'Create an Account',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontFamily: 'Uni Neue',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      'Register to continue',
                                      style: TextStyle(
                                        color: Color(0xFF787878),
                                        fontSize: 20,
                                        fontFamily: 'Uni Neue',
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    )),
                                Column(
                                  children: [
                                    const SizedBox(height: 25),
                                    Theme(
                                      data: Theme.of(context).copyWith(
                                        primaryColor: customColor,
                                        textSelectionTheme: TextSelectionThemeData(
                                          cursorColor: customColor,
                                          selectionColor: customColor.withOpacity(0.5),
                                          selectionHandleColor: customColor,
                                        ),
                                        inputDecorationTheme:
                                        const InputDecorationTheme(
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: customColor),
                                          ),
                                        ),
                                      ),
                                      child: TextField(
                                        keyboardType: TextInputType.emailAddress,
                                        controller: _controllerEmail,
                                        decoration: const InputDecoration(
                                          hintText: "Email Address",
                                          hintStyle: TextStyle(
                                            color: Color(0xFF787878),
                                            fontSize: 14,
                                            fontFamily: 'Uni Neue',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                        cursorColor: customColor,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Theme(
                                      data: Theme.of(context).copyWith(
                                        primaryColor: customColor,
                                        textSelectionTheme: TextSelectionThemeData(
                                          cursorColor: customColor,
                                          selectionColor: customColor.withOpacity(0.5),
                                          selectionHandleColor: customColor,
                                        ),
                                        inputDecorationTheme:
                                        const InputDecorationTheme(
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: customColor),
                                          ),
                                        ),
                                      ),
                                      child: TextField(
                                        keyboardType: TextInputType.visiblePassword,
                                        controller: _controllerPassword,
                                        decoration: const InputDecoration(
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                            color: Color(0xFF787878),
                                            fontSize: 14,
                                            fontFamily: 'Uni Neue',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                        cursorColor: customColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Forget Password?',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFFF26B6C),
                                          fontSize: 14,
                                          fontFamily: 'Uni Neue',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Center(
                                    child: authButton("SIGN IN", () {
                                      MySharedPreference.setEmail(_controllerEmail.text);
                                      context.read<LoginBloc>().add(ClickSignInEvent(
                                          _controllerEmail.text, _controllerPassword.text));
                                    })),
                                const SizedBox(height: 30),
                                const Center(
                                  child: Text(
                                    'or sign in using',
                                    style: TextStyle(
                                      color: Color(0xFF787878),
                                      fontSize: 14,
                                      fontFamily: 'Uni Neue',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          context
                                              .read<LoginBloc>()
                                              .add(ClickSignInWithGoogleEvent());
                                        },
                                        child:
                                        Image.asset("assets/images/ic_google.png")),
                                    const SizedBox(width: 18),
                                    InkWell(
                                        onTap: () {
                                          context
                                              .read<LoginBloc>()
                                              .add(ClickSignInWithFbEvent());
                                        },
                                        child: Image.asset(
                                            "assets/images/ic_facebook.png")),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Don’t have an account?",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'Uni Neue',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        context
                                            .read<LoginBloc>()
                                            .add(ClickRegisterEvent());
                                      },
                                      child: const Text(
                                        " Register",
                                        style: TextStyle(
                                          color: Color(0xFFD71920),
                                          fontSize: 14,
                                          fontFamily: 'Uni Neue',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (state is LoadingSignInState)
                          const Center(
                            child: CircularProgressIndicator(color: Color(0xFFF26B6C)),
                          ),
                      ],
                    ))),
          );
        },
      ),
    );
  }
}
