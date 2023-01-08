import 'dart:async';
import 'dart:io';
import 'package:misjif/templater.dart';
import 'post.dart';

String? renderHtml(String path) {
  Post post = Post(path);
  return buildPost(post);
}

Future<void> printPostToConsole(String postPath) async {
  var post = renderHtml(postPath);
  print(post);
}

Future<void> generatePostFile(String postPath) async {
  var post = renderHtml(postPath);
  if(post != null) {
    try {
      var file = await File('public/posts/post1.html').create(recursive: true);
      file.writeAsStringSync(post);
    } catch (e) {
      print(e);
    }
  }
}
