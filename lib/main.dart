import 'package:flutter/material.dart';
import 'package:photoshare/common/router.dart';
import 'package:photoshare/common/splash_screen.dart';
import 'package:photoshare/features/addpost/repository/add_post_repository.dart';
import 'package:photoshare/features/auth/repository/auth_repository.dart';
import 'package:photoshare/features/auth/repository/create_repository.dart';
import 'package:photoshare/features/home/repository/home_repository.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthRepository(),
        ),
        ChangeNotifierProvider(
          create: (_) => CreteProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AddPostRepository(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeRepository(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) => generateRoute(settings),
        initialRoute: SplashScreen.routeName,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
                color: Colors.white,
                iconTheme: IconThemeData(color: Colors.black)),
            colorSchemeSeed: Colors.red,
            brightness: Brightness.light),
        color: Colors.red,
      ),
    );
  }
}
