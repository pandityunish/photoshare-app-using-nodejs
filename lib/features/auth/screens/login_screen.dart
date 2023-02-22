import 'package:flutter/material.dart';
import 'package:photoshare/common/handle_error.dart';
import 'package:photoshare/common/loading_screen.dart';
import 'package:photoshare/features/auth/repository/auth_repository.dart';
import 'package:photoshare/features/auth/screens/register_screen.dart';
import 'package:provider/provider.dart';

import '../widgets/textformhelper.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login-screen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginglobalkey = GlobalKey<FormState>();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  bool isloading = false;
  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  void loginuser() {
    setState(() {
      isloading = true;
    });
    if (emailcontroller.text.isNotEmpty && passwordcontroller.text.isNotEmpty) {
      Provider.of<AuthRepository>(context, listen: false).loginuser(
          context: context,
          email: emailcontroller.text.trim(),
          password: passwordcontroller.text.trim());
      setState(() {
        isloading = false;
      });
    } else {
      showsnackbar(context, "Something is wrong");
      isloading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading
          ? const Loader()
          : SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: loginglobalkey,
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        height: 160,
                        width: 200,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "WELCOME BACK",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Enter your credentials to continue",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextformHelper(
                          controller: emailcontroller,
                          ispass: false,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.emailAddress,
                          hintText: "Email Address"),
                      TextformHelper(
                          controller: passwordcontroller,
                          ispass: true,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.name,
                          hintText: "Password"),
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forget password?",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 17,
                                  decoration: TextDecoration.underline),
                            )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: loginuser,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.red,
                              ),
                              child: const Center(
                                child: Text(
                                  "LOG IN",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CreateAccount(),
                                    ));
                              },
                              child: const Text(
                                "Sigin",
                                style: TextStyle(color: Colors.red),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
