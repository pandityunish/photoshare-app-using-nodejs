import 'package:flutter/material.dart';
import 'package:photoshare/features/auth/repository/create_repository.dart';
import 'package:photoshare/features/home/repository/home_repository.dart';
import 'package:photoshare/features/home/widgets/post_card.dart';
import 'package:photoshare/models/post_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/widgets/search_bar.dart';
import '../../auth/repository/auth_repository.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = "/category-screen";
  final String category;
  const CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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
        .getpostcategory(context: context, category: widget.category);
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
      body: RefreshIndicator(
        onRefresh: () {
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  pageBuilder: (a, b, c) =>
                      CategoryScreen(category: widget.category),
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
                    .getpostcategory(
                        context: context, category: widget.category),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    if (snapshot.data!.isEmpty) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: const Center(
                          child: Text("NO PHOTOS"),
                        ),
                      );
                    }
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
