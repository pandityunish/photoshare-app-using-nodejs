import 'package:flutter/material.dart';
import 'package:photoshare/features/home/widgets/post_card.dart';

import '../../../models/post_model.dart';

class SearchPhotoDelecates extends SearchDelegate {
  final List<Post> posts;

  SearchPhotoDelecates(this.posts);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Post> matchQuery = [];
    for (var item in posts) {
      if (item.title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        final data = matchQuery[index];
        return PostCard(
            image: data.image,
            userimage: data.userimage,
            username: data.username,
            post: data);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Post> matchQuery = [];
    for (var item in posts) {
      if (item.title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        final data = matchQuery[index];
        return InkWell(
          onTap: () {
            query = data.title;
          },
          child: ListTile(
            title: Text(data.title),
          ),
        );
      },
    );
  }
}
