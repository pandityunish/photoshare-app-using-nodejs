import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/auth_repository.dart';
import '../repository/create_repository.dart';

class UserProfile extends StatefulWidget {
  final String username;
  final String userimage;
  final String userid;
  static const String routeName = "user-profile";
  const UserProfile(
      {super.key,
      required this.username,
      required this.userid,
      required this.userimage});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final double coverhight = 360;
  String? image;
  void getemail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    image = sharedPreferences.getString("image");
    setState(() {});
  }

  @override
  void initState() {
    getemail();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CreteProvider>(context, listen: false).getuser;
    final top = coverhight - 40;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title: Image.asset("assets/logo.png"),
        actions: [
          image != null
              ? InkWell(
                  onTap: () {
                    Provider.of<AuthRepository>(context, listen: false)
                        .signout(context);
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(image!),
                  ),
                )
              : const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: coverhight,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://images.unsplash.com/photo-1460472178825-e5240623afd5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=869&q=80"))),
                ),
                Positioned(
                  top: top,
                  child: Stack(children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.black)),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(widget.userimage),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              widget.username,
              style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.red,
                  ),
                  child: const Center(
                    child: Text(
                      "Created",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  height: 40,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.red,
                  ),
                  child: const Center(
                    child: Text(
                      "Saved",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                user.id == widget.userid
                    ? InkWell(
                        onTap: () {
                          Provider.of<AuthRepository>(context, listen: false)
                              .signout(context);
                        },
                        child: Container(
                          height: 40,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.red,
                          ),
                          child: const Center(
                            child: Text(
                              "Logout",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(
                        height: 0,
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
