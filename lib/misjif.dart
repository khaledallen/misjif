import 'dart:async';
import 'dart:io';
import 'package:misjif/templater.dart';
import 'post.dart';

String buildPostUrl(Post post) {
  String newName = post.path.split('/')[1].split('.')[0];
  return '<a href="posts/$newName.html">$newName</a>';
}

Future<void> generatePostFile(Post post, {bool debug = false}) async {
  String postHtml = buildPost(post);
  if(debug) {
    print(postHtml);
  }

  String newName = post.path.split('/')[1].split('.')[0];
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
  List<Post> postList = [];
  List<String> postLinks = [];
  for(var file in posts) {
    if(file.path.contains('.md')) {
      Post post = Post(file.path);
      postList.add(post);
      generatePostFile(post, debug: true);
      postLinks.add(buildPostUrl(post));
    }
  }
  print(postLinks);

}