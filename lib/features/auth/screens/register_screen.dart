import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photoshare/common/handle_error.dart';
import 'package:photoshare/common/loading_screen.dart';
import 'package:photoshare/features/auth/repository/auth_repository.dart';
import 'package:provider/provider.dart';

import '../widgets/textformhelper.dart';

class CreateAccount extends StatefulWidget {
  static const String routeName = "/create-account";
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  bool isloading = false;
  @override
  void dispose() {
    namecontroller.dispose();
    passwordcontroller.dispose();
    emailcontroller.dispose();
    super.dispose();
  }

  XFile? image;

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

  void createaccount() async {
    setState(() {
      isloading = true;
    });

    if (emailcontroller.text.isNotEmpty &&
        namecontroller.text.isNotEmpty &&
        passwordcontroller.text.isNotEmpty &&
        image!.path.isNotEmpty) {
      Provider.of<AuthRepository>(context, listen: false).createuser(
          context: context,
          name: namecontroller.text.trim(),
          email: emailcontroller.text.trim(),
          password: emailcontroller.text.trim(),
          image: image!.path);
      setState(() {
        isloading = false;
      });
    } else {
      showsnackbar(context, "Something is wrong");
      setState(() {
        isloading = false;
      });
    }
  }

  final createformkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Create new  account",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: isloading
          ? const Loader()
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        image == null
                            ? ClipOval(
                                child: Image.asset(
                                  "assets/user.png",
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                ),
                              )
                            : ClipOval(
                                child: Image.file(
                                  File(image!.path),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        Positioned(
                            bottom: -3,
                            right: -2,
                            child: IconButton(
                                onPressed: () {
                                  pickimage();
                                },
                                icon: const Icon(Icons.camera_alt))),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextformHelper(
                      hintText: "Enter Name",
                      ispass: false,
                      textInputType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      controller: namecontroller),
                  const SizedBox(
                    height: 10,
                  ),
                  TextformHelper(
                      hintText: "Enter Email",
                      ispass: false,
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      controller: emailcontroller),
                  const SizedBox(
                    height: 10,
                  ),
                  TextformHelper(
                      hintText: "Enter Password",
                      ispass: true,
                      textInputType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      controller: passwordcontroller),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      createaccount();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                      ),
                      child: const Center(
                        child: Text(
                          "CREATE ACCOUNT",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
