import 'dart:async';
import 'dart:io';
import 'post.dart';
import 'package:misjif/parser.dart';
import 'package:misjif/renderer.dart';


String buildPostUrl(Post post) {
  String newName = post.path.split('/')[1].split('.')[0];
  return '<a href="posts/$newName.html">$newName</a>';
}

Future<void> generatePostFile(Post post, {bool debug = false}) async {
  var postTemplate = File('templates/post.html').readAsStringSync();
  Parser parser = Parser(postTemplate);
  List<String> parsed = parser.parse();
  if(debug) {
    print('Parser produced: $parsed');
  }

  String newName = post.path.split('/')[1].split('.')[0];
  try {
    var file = await File('public/posts/$newName.html').create(recursive: true);
    Renderer renderer = Renderer(parsed, post);
    var rendered = renderer.render();
    file.writeAsStringSync(rendered);
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