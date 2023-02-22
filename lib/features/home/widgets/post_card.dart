import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photoshare/features/auth/screens/user_profile.dart';
import 'package:photoshare/features/home/screens/details_page.dart';
import 'package:photoshare/models/post_model.dart';

class PostCard extends StatelessWidget {
  final String image;
  final String userimage;
  final String username;
  final Post post;
  const PostCard(
      {super.key,
      required this.image,
      required this.userimage,
      required this.username,
      required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, DetailsPage.routeName,
                  arguments: {"post": post});
            },
            child: CachedNetworkImage(
              imageBuilder: (context, imageProvider) => Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              imageUrl: image,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 223, 223, 223),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),

          // Container(
          //   height: 140,
          //   width: double.infinity,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       image: DecorationImage(
          //         image: NetworkImage(
          //           image,
          //         ),
          //       )),
          // ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, UserProfile.routeName, arguments: {
                "username": post.username,
                "userimage": post.userimage,
                "userid": post.userid
              });
            },
            child: Row(
              children: [
                CircleAvatar(
                  radius: 23,
                  backgroundImage: NetworkImage(userimage),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  username,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 23),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
