import 'package:flutter/material.dart';
import 'package:photoshare/common/splash_screen.dart';
import 'package:photoshare/features/addpost/screens/add_post.dart';
import 'package:photoshare/features/auth/screens/login_screen.dart';
import 'package:photoshare/features/auth/screens/register_screen.dart';
import 'package:photoshare/features/auth/screens/user_profile.dart';
import 'package:photoshare/features/home/screens/category_screen.dart';
import 'package:photoshare/features/home/screens/details_page.dart';
import 'package:photoshare/features/home/screens/home_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case CreateAccount.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case HomeScren.routeName:
      return MaterialPageRoute(
        builder: (context) => const HomeScren(),
      );
    case SplashScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      );
    case AddPost.routeName:
      return MaterialPageRoute(
        builder: (context) => const AddPost(),
      );
    case DetailsPage.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final post = arguments["post"];
      return MaterialPageRoute(
        builder: (context) => DetailsPage(post: post),
      );
    case CategoryScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final category = arguments["category"];
      return MaterialPageRoute(
        builder: (context) => CategoryScreen(category: category),
      );
    case UserProfile.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final username = arguments["username"];
      final userimage = arguments["userimage"];
      final userid = arguments["userid"];
      return MaterialPageRoute(
        builder: (context) => UserProfile(
            userid: userid, username: username, userimage: userimage),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      );
  }
}
