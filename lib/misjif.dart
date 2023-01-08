import 'dart:async';
import 'dart:io';
import 'package:misjif/templater.dart';
import 'post.dart';

Future<void> printPostToConsole(String path) async {
  Post post = Post(path);
  String postHtml = buildPost(post);
  print(postHtml);
}

Future<void> generatePostFiles(String path) async {
  Post post = Post(path);
  String postHtml = buildPost(post);

  String newName = path.split('/')[1].split('.')[0];
  try {
    var file = await File('public/posts/$newName.html').create(recursive: true);
    file.writeAsStringSync(postHtml);
  } catch (e) {
    print(e);
  }
}

void processPosts(String dir) {
  var postDirectory = Directory(dir);
  var posts = postDirectory.listSync();
  for(var file in posts) {
    if(file.path.contains('.md')) {
      printPostToConsole(file.path);
      generatePostFiles(file.path);
    }
  }
}