import 'package:flutter/material.dart';
import 'package:photoshare/features/addpost/screens/add_post.dart';
import 'package:photoshare/features/auth/repository/auth_repository.dart';
import 'package:photoshare/features/search/screens/search_screen.dart';
import 'package:provider/provider.dart';

import '../../features/home/repository/home_repository.dart';
import '../../models/post_model.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  List<Post> posts = [];
  void getdata() async {
    posts = await Provider.of<HomeRepository>(context, listen: false)
        .getallpost(context: context);
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            showSearch(context: context, delegate: SearchPhotoDelecates(posts));
          },
          child: Card(
            elevation: 3,
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(Icons.search,
                          color: Color.fromARGB(255, 202, 202, 202)),
                      Text(
                        "Search Here",
                        style: TextStyle(
                            color: Color.fromARGB(255, 212, 212, 212)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            // Provider.of<AuthRepository>(context, listen: false)
            //     .signout(context);
            Navigator.pushNamed(context, AddPost.routeName);
          },
          child: Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
