import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Downloadmovie extends StatefulWidget {
  final String url;
  final String name;
  const Downloadmovie({super.key, required this.url, required this.name});

  @override
  State<Downloadmovie> createState() => _DownloadmovieState();
}

class _DownloadmovieState extends State<Downloadmovie> {
  Dio dio = Dio();
  double progress = 0.0;
  void startDownloading() async {
    String filename = "${widget.name}.png";
    String path = await _getFilePath(filename);

    await dio.download(widget.url, path,
        onReceiveProgress: (recivedBytes, totalBytes) {
      setState(() {
        progress = recivedBytes / totalBytes;
      });
    }, deleteOnError: true).then((_) {
      Navigator.pop(context);
    });
  }

  Future<String> _getFilePath(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    print(dir);
    return "${dir.path}/$filename";
  }

  @override
  void initState() {
    startDownloading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String downloadingprogress = (progress * 100).toInt().toString();

    return AlertDialog(
      backgroundColor: Colors.black,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator.adaptive(),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Downloading: $downloadingprogress%",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
