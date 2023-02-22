import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:photoshare/models/comment_model.dart';

import '../../../common/global.dart';
import '../../../common/handle_error.dart';
import '../../../models/post_model.dart';
import 'package:http/http.dart' as http;

class HomeRepository with ChangeNotifier {
  Future<List<Post>> getallpost({required BuildContext context}) async {
    List<Post> posts = [];
    try {
      http.Response res = await http
          .get(Uri.parse("$url/getallpost"), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
      handleerror(
          res: res,
          callback: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              posts.add(Post.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          },
          context: context);
    } catch (e) {
      showsnackbar(context, e.toString());
    }
    return posts;
  }

  Future<List<Post>> getpostcategory(
      {required BuildContext context, required String category}) async {
    List<Post> posts = [];
    try {
      http.Response res = await http.post(Uri.parse("$url/getcategory"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({"category": category}));
      handleerror(
          res: res,
          callback: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              posts.add(Post.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          },
          context: context);
    } catch (e) {
      showsnackbar(context, e.toString());
    }
    return posts;
  }

  Future<List<CommentModel>> getpostcomment(
      {required BuildContext context, required String postid}) async {
    List<CommentModel> comment = [];
    try {
      await http
          .post(Uri.parse("$url/getpostcomment"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode({"postid": postid}))
          .then((res) {
        return handleerror(
            res: res,
            callback: () {
              for (int i = 0; i < jsonDecode(res.body).length; i++) {
                comment.add(
                    CommentModel.fromJson(jsonEncode(jsonDecode(res.body)[i])));
              }
            },
            context: context);
      });
    } catch (e) {
      showsnackbar(context, e.toString());
    }
    return comment;
  }

  void postcomment(
      {required BuildContext context,
      required String commenttitle,
      required String username,
      required String userimage,
      required String postid}) async {
    try {
      CommentModel model = CommentModel(
          commenttitle: commenttitle,
          username: username,
          userimage: userimage,
          postid: postid);
      await http
          .post(Uri.parse("$url/addpostcomment"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: model.toJson())
          .then((res) {
        return handleerror(
            res: res,
            callback: () {
              showsnackbar(context, "Added Successfully");
            },
            context: context);
      });
    } catch (e) {
      showsnackbar(context, e.toString());
    }
  }
}
