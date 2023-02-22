import 'dart:async';

import 'package:flutter/material.dart';
import 'package:photoshare/features/auth/repository/auth_repository.dart';
import 'package:photoshare/features/auth/screens/login_screen.dart';
import 'package:photoshare/features/home/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/splash-screen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? email;
  void getemail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    email = sharedPreferences.getString("email");
    setState(() {});
  }

  @override
  void initState() {
    getemail();
    Timer(
      const Duration(seconds: 5),
      () {
        if (email != null) {
          Provider.of<AuthRepository>(context, listen: false)
              .getuserdata(context: context);
          Navigator.pushNamed(context, HomeScren.routeName);
        } else {
          Navigator.pushNamed(context, LoginScreen.routeName);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/logo.png",
        ),
      ),
    );
  }
}
