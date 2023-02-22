import 'package:flutter/material.dart';
import 'package:photoshare/features/home/screens/category_screen.dart';
import 'package:photoshare/features/home/screens/home_screen.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  List category = [
    {
      "name": "Car",
      "image":
          "https://images.unsplash.com/photo-1494976388531-d1058494cdd8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
    },
    {
      "name": "Fitness",
      "image":
          "https://images.unsplash.com/photo-1518611012118-696072aa579a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fGZpdG5lc3N8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
    },
    {
      "name": "Wallpaper",
      "image":
          "https://images.unsplash.com/photo-1511300636408-a63a89df3482?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
    },
    {
      "name": "Websites",
      "image":
          "https://images.unsplash.com/photo-1507238691740-187a5b1d37b8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=455&q=80",
    },
    {
      "name": "Photo",
      "image":
          "https://images.unsplash.com/photo-1554080353-a576cf803bda?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cGhvdG98ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
    },
    {
      "name": "Food",
      "image":
          "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Zm9vZHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
    },
    {
      "name": "Art",
      "image":
          "https://images.unsplash.com/photo-1513364776144-60967b0f800f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=871&q=80",
    },
    {
      "name": "Travel",
      "image":
          "https://images.unsplash.com/photo-1530521954074-e64f6810b32d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dHJhdmVsfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
    },
    {
      "name": "Quotes",
      "image":
          "https://images.unsplash.com/photo-1564410267841-915d8e4d71ea?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cXVvdGVzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
    },
    {
      "name": "Cats",
      "image":
          "https://images.unsplash.com/photo-1592194996308-7b43878e84a6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Q2F0c3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
    },
    {
      "name": "Dogs",
      "image":
          "https://images.unsplash.com/photo-1517849845537-4d257902454a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8RG9nfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Image.asset("assets/logo.png"),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomeScren.routeName, (route) => false);
                },
                title: const Text(
                  "Home",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: const Icon(
                  Icons.home,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Discover Category",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                itemCount: category.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, CategoryScreen.routeName,
                            arguments: {"category": category[index]["name"]});
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                NetworkImage(category[index]["image"]),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            category[index]["name"],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
