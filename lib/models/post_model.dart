import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Post {
  final String id;
  final String title;
  final String username;
  final String userimage;
  final String userid;
  final String image;
  final String description;
  final String link;
  final String category;
  Post({
    required this.id,
    required this.title,
    required this.username,
    required this.userimage,
    required this.userid,
    required this.image,
    required this.description,
    required this.link,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'username': username,
      'userimage': userimage,
      'userid': userid,
      'image': image,
      'description': description,
      'link': link,
      'category': category,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['_id'] as String,
      title: map['title'] as String,
      username: map['username'] as String,
      userimage: map['userimage'] as String,
      userid: map['userid'] as String,
      image: map['image'] as String,
      description: map['description'] as String,
      link: map['link'] as String,
      category: map['category'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);
}
