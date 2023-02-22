import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photoshare/models/comment_model.dart';
import 'package:photoshare/models/post_model.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/download_page.dart';
import '../../../common/widgets/search_bar.dart';
import '../../auth/repository/create_repository.dart';
import '../repository/home_repository.dart';

class DetailsPage extends StatefulWidget {
  static const String routeName = "/detail-page";
  final Post post;
  const DetailsPage({super.key, required this.post});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  List<CommentModel> comments = [];
  final TextEditingController commentcontroller = TextEditingController();
  @override
  void dispose() {
    commentcontroller.dispose();
    super.dispose();
  }

  String? image;
  void getemail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    image = sharedPreferences.getString("image");
    setState(() {});
  }

  List<Post> posts = [];
  void getalllikeposts() async {
    posts = await Provider.of<HomeRepository>(context, listen: false)
        .getpostcategory(context: context, category: widget.post.category);

    setState(() {});
  }

  void getpostcomment() async {
    comments = await Provider.of<HomeRepository>(context, listen: false)
        .getpostcomment(context: context, postid: widget.post.id);

    setState(() {});
  }

  @override
  void initState() {
    getemail();
    getpostcomment();
    getalllikeposts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CreteProvider>(context, listen: false).getuser;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title: Image.asset("assets/logo.png"),
        actions: [
          image != null
              ? CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(image!),
                )
              : const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  pageBuilder: (a, b, c) => DetailsPage(
                        post: widget.post,
                      ),
                  transitionDuration: const Duration(seconds: 0)));
          return Future.value();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const SearchBar(),
                const SizedBox(
                  height: 10,
                ),
                CachedNetworkImage(
                  imageBuilder: (context, imageProvider) => Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  imageUrl: widget.post.image,
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
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Downloadmovie(
                                  url: widget.post.image,
                                  name: widget.post.title);
                            },
                          );
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: const Color.fromARGB(255, 240, 240, 240)),
                          child: const Center(
                            child: Icon(Icons.downloading),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: InkWell(
                        onTap: () async {
                          await Share.share(widget.post.image,
                              subject: "Image");
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: const Color.fromARGB(255, 240, 240, 240)),
                          child: const Center(
                            child: Icon(Icons.share),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  widget.post.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 26),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.post.description,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(widget.post.userimage),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.post.username,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 23),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Comment",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                ListView.builder(
                  itemCount: comments.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (comments.isEmpty) {
                      return const Center(
                        child: Text("No comments"),
                      );
                    } else {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(comments[index].userimage),
                        ),
                        title: Text(comments[index].username),
                        subtitle: Text(comments[index].commenttitle),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(user.image),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextFormField(
                        controller: commentcontroller,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            hintText: "Add Comment"),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Provider.of<HomeRepository>(context, listen: false)
                        .postcomment(
                            context: context,
                            commenttitle: commentcontroller.text.trim(),
                            username: user.name,
                            userimage: user.image,
                            postid: widget.post.id);
                    comments.add(CommentModel(
                        commenttitle: commentcontroller.text.trim(),
                        username: user.name,
                        userimage: user.image,
                        postid: widget.post.id));
                    commentcontroller.clear();
                    setState(() {});
                  },
                  child: Container(
                    height: 40,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red,
                    ),
                    child: const Center(
                      child: Text(
                        "Done",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "More like this",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ],
                ),
                FutureBuilder<List<Post>>(
                  future: Provider.of<HomeRepository>(context, listen: false)
                      .getpostcategory(
                          context: context, category: widget.post.category),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: posts.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final data = snapshot.data![index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, DetailsPage.routeName,
                                        arguments: {"post": data});
                                  },
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth: double.infinity,
                                        maxHeight:
                                            MediaQuery.of(context).size.height *
                                                0.7),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(data.image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 23,
                                      backgroundImage:
                                          NetworkImage(data.userimage),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      data.username,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 23),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
