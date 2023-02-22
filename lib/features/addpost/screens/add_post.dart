import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photoshare/features/auth/repository/create_repository.dart';
import 'package:provider/provider.dart';

import '../../../common/handle_error.dart';
import '../../../common/widgets/search_bar.dart';
import '../repository/add_post_repository.dart';

class AddPost extends StatefulWidget {
  static const String routeName = "add-post";
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final TextEditingController titlecontroller = TextEditingController();
  final TextEditingController desccontroller = TextEditingController();
  final TextEditingController linkcontroller = TextEditingController();
  bool isloading = false;
  XFile? image;
  String categoty = "Select Category";
  List<String> porductCategories = [
    "Select Category",
    "Car",
    "Fitness",
    "Wallpaper",
    "Website",
    "Photo",
    "Food",
    "Nature",
    "Travel",
    "Quotes",
    "Cat",
    "Dog",
    "Others"
  ];
  void pickimage() async {
    try {
      XFile? _image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      image = _image;
      setState(() {});
    } catch (e) {
      showsnackbar(context, e.toString());
    }
  }

  void addpost(String username, String userimage, String userid) async {
    setState(() {
      isloading = true;
    });
    await _simulateNetworkRequest().whenComplete(() {
      Provider.of<AddPostRepository>(context, listen: false).addpost(
          context: context,
          image: image!.path,
          title: titlecontroller.text.trim(),
          username: username,
          userimage: userimage,
          userid: userid,
          description: desccontroller.text.trim(),
          link: linkcontroller.text.trim(),
          category: categoty);
    });

    await _simulateNetworkRequest();

    setState(() {
      isloading = false;
    });
  }

  Future<void> _simulateNetworkRequest() async {
    await Future.delayed(Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CreteProvider>(context, listen: false).getuser;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset("assets/logo.png")),
        actions: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(user.image),
          )
        ],
      ),
      drawer: const Drawer(),
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const SearchBar(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: pickimage,
                        child: Container(
                          height: 300,
                          width: double.infinity,
                          color: const Color.fromARGB(255, 235, 234, 234),
                          child: image != null
                              ? Stack(
                                  children: [
                                    Image.file(
                                      File(image!.path),
                                      height: 300,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        right: 10,
                                        child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                image = null;
                                              });
                                            },
                                            icon: const CircleAvatar(
                                                radius: 35,
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.black,
                                                ))))
                                  ],
                                )
                              : SizedBox(
                                  height: 240,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.cloud_upload_outlined),
                                      Text("Click To Upload"),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "Recommendation: Use high-quality JPG, JPEG, SVG, PNG, GIF or TIFF less than 20MB",
                                          style: TextStyle(),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        controller: titlecontroller,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                            hintText: "Add your title",
                            hintStyle: TextStyle(fontSize: 23))),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(user.image),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          user.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        controller: desccontroller,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          hintText: "Tell everyone what your photo is about",
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        controller: linkcontroller,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          hintText: "Add a destination link",
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Choose Pin Category",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: DropdownButton(
                            alignment: Alignment.center,
                            underline: Container(
                              color: Colors.white,
                            ),
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                            items: porductCategories.map((String item) {
                              return DropdownMenuItem(
                                  value: item, child: Text(item));
                            }).toList(),
                            value: categoty,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            onChanged: (String? newval) {
                              setState(() {
                                categoty = newval!;
                              });
                            }),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            if (isloading == true) {
                              print("This is loading");
                            }
                            addpost(user.name, user.image, user.id);
                          },
                          child: Container(
                            height: 40,
                            width: 90,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                              child: Text(
                                "Save Pin",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
