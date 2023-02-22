import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:photoshare/common/global.dart';
import 'package:photoshare/common/handle_error.dart';
import 'package:photoshare/models/post_model.dart';
import 'package:http/http.dart' as http;

class AddPostRepository with ChangeNotifier {
  void addpost(
      {required BuildContext context,
      required String image,
      required String title,
      required String username,
      required String userimage,
      required String userid,
      required String description,
      required String link,
      required String category}) async {
    try {
      final cloudinary = CloudinaryPublic("dsqtxanz6", "l9djmh0i");
      CloudinaryResponse response = await cloudinary
          .uploadFile(CloudinaryFile.fromFile(image, folder: "Postimage"));
      String imageurl = response.secureUrl;
      Post post = Post(
          id: "",
          title: title,
          username: username,
          userimage: userimage,
          userid: userid,
          image: imageurl,
          description: description,
          link: link,
          category: category);
      http.Response res = await http.post(Uri.parse("$url/addpost"),
          body: post.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      handleerror(
          res: res,
          callback: () {
            Navigator.pop(context);
          },
          context: context);
    } catch (e) {
      showsnackbar(context, e.toString());
      print(e.toString());
    }
  }
}
