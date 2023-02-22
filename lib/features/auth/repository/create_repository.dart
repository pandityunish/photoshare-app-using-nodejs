import 'package:flutter/cupertino.dart';
import 'package:photoshare/models/usermodel.dart';

class CreteProvider with ChangeNotifier {
  UserModel user = UserModel(
    id: "",
    name: "",
    password: "",
    email: "",
    image: "",
  );
  UserModel get getuser => user;

  void setuser(String user1) {
    user = UserModel.fromJson(user1);
    notifyListeners();
  }
}
