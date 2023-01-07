import 'dart:async';
import 'dart:io';
import 'Post.dart';

String renderHtml(String path) {
  Post post = Post(path);
  var postTemplate = File('templates/post.html').readAsStringSync();
  postTemplate = postTemplate.replaceAll(RegExp(r'{{ post.title }}'), post.title);
  postTemplate = postTemplate.replaceAll(RegExp(r'{{ post }}'), post.content);
  return postTemplate;
}

Future<void> printPostToConsole(String postPath) async {
  var post = renderHtml(postPath);
  print(post);
}

Future<void> generatePostFile(String postPath) async {
  var post = renderHtml(postPath);
  try {
    var file = await File('public/posts/post1.html').create(recursive: true);
    file.writeAsStringSync(post);
  } catch (e) {
    print(e);
  }
}