import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:photoshare/common/global.dart';
import 'package:photoshare/common/handle_error.dart';
import 'package:http/http.dart' as http;
import 'package:photoshare/features/auth/repository/create_repository.dart';
import 'package:photoshare/features/auth/screens/login_screen.dart';
import 'package:photoshare/features/home/screens/home_screen.dart';
import 'package:photoshare/models/usermodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository with ChangeNotifier {
  void createuser(
      {required BuildContext context,
      required String name,
      required String email,
      required String password,
      required String image}) async {
    try {
      final cloudinary = CloudinaryPublic("dsqtxanz6", "l9djmh0i");
      CloudinaryResponse response = await cloudinary
          .uploadFile(CloudinaryFile.fromFile(image, folder: name));
      String imageurl = response.secureUrl;
      UserModel user = UserModel(
          id: '',
          name: name,
          email: email,
          image: imageurl,
          password: password);
      http.Response res = await http.post(Uri.parse("$url/auth/createuser"),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      handleerror(
          res: res,
          callback: () async {
            showsnackbar(context, "User created successfully");
            Provider.of<CreteProvider>(context, listen: false)
                .setuser(res.body);
            final user =
                Provider.of<CreteProvider>(context, listen: false).getuser;

            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.setString("image", user.image);
            preferences.setString("email", email).whenComplete(() {
              Navigator.pushNamed(context, HomeScren.routeName);
            });
          },
          context: context);
    } catch (e) {
      showsnackbar(context, e.toString());
    }
  }

  void loginuser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      http.Response res = await http.post(Uri.parse("$url/auth/login"),
          body: jsonEncode({"email": email, "password": password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      handleerror(
          res: res,
          callback: () async {
            showsnackbar(context, "Login Successfull");
            Provider.of<CreteProvider>(context, listen: false)
                .setuser(res.body);
            final user =
                Provider.of<CreteProvider>(context, listen: false).getuser;

            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.setString("image", user.image);
            preferences.setString("email", email).whenComplete(() {
              Navigator.pushNamed(context, HomeScren.routeName);
            });
          },
          context: context);
    } catch (e) {
      showsnackbar(context, e.toString());
    }
  }

  void getuserdata({required BuildContext context}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? email = preferences.getString("email");

      http.Response res = await http.post(
          Uri.parse(
            "$url/getuserdata",
          ),
          body: jsonEncode({"email": email}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      handleerror(
          res: res,
          callback: () async {
            Provider.of<CreteProvider>(context, listen: false)
                .setuser(res.body);
            final user =
                Provider.of<CreteProvider>(context, listen: false).getuser;
            SharedPreferences preferences =
                await SharedPreferences.getInstance();

            preferences.setString("image", user.image).whenComplete(() {
              Navigator.pushNamed(context, HomeScren.routeName);
            });
          },
          context: context);
    } catch (e) {
      showsnackbar(context, e.toString());
    }
  }

  void signout(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.remove("email").whenComplete(() {
      Navigator.pushNamed(context, LoginScreen.routeName);
    });
  }
}
