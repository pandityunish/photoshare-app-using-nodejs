import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CommentModel {
  final String commenttitle;
  final String username;
  final String userimage;
  final String postid;
  CommentModel({
    required this.commenttitle,
    required this.username,
    required this.userimage,
    required this.postid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'commenttitle': commenttitle,
      'username': username,
      'userimage': userimage,
      'postid': postid,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      commenttitle: map['commenttitle'] as String,
      username: map['username'] as String,
      userimage: map['userimage'] as String,
      postid: map['postid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
