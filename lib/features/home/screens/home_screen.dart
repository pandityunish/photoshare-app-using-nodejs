import 'package:flutter/material.dart';
import 'package:photoshare/common/widgets/drawer.dart';
import 'package:photoshare/common/widgets/search_bar.dart';
import 'package:photoshare/features/auth/screens/user_profile.dart';
import 'package:photoshare/features/home/repository/home_repository.dart';
import 'package:photoshare/features/home/widgets/post_card.dart';
import 'package:photoshare/models/post_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth/repository/create_repository.dart';

class HomeScren extends StatefulWidget {
  static const String routeName = "/home-screen";
  const HomeScren({super.key});

  @override
  State<HomeScren> createState() => _HomeScrenState();
}

class _HomeScrenState extends State<HomeScren> {
  String? image;
  void getemail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    image = sharedPreferences.getString("image");
    setState(() {});
  }

  @override
  void initState() {
    getemail();
    Provider.of<HomeRepository>(context, listen: false)
        .getallpost(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CreteProvider>(context, listen: false).getuser;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title: Image.asset("assets/logo.png"),
        actions: [
          image != null
              ? InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, UserProfile.routeName,
                        arguments: {
                          "username": user.name,
                          "userimage": image,
                          "userid": user.id
                        });
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
      drawer: const DrawerPage(),
      body: RefreshIndicator(
        onRefresh: () {
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  pageBuilder: (a, b, c) => const HomeScren(),
                  transitionDuration: const Duration(seconds: 0)));
          return Future.value();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const SearchBar(),
              FutureBuilder<List<Post>>(
                future: Provider.of<HomeRepository>(context, listen: false)
                    .getallpost(context: context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final data = snapshot.data![index];
                        return PostCard(
                            post: data,
                            image: data.image,
                            userimage: data.userimage,
                            username: data.username);
                      },
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
