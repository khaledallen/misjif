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
    var data = {
      'title': post.title,
      'date': post.getFormattedDate(),
      'content': post.content
    };
    Renderer renderer = Renderer(parsed, data);
    var rendered = renderer.render();
    file.writeAsStringSync(rendered);
  } catch (e) {
    print('Error generating post file: $e');
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
      generatePostFile(post);
      postLinks.add(buildPostUrl(post));
    }
  }
  generateIndex(postLinks, debug: true);

}

Future<void> generateIndex(postLinks, {bool debug = false}) async {
  var indexTemplate = File('templates/index.html').readAsStringSync();
  Parser parser = Parser(indexTemplate);
  var parsedIndex = parser.parse();

  var file = await File('public/index.html').create(recursive: true);
  Map<String, dynamic> data = {
    'title': 'main page',
    'postList': postLinks.toString(),
  };
  Renderer renderer = Renderer(parsedIndex, data);
  var rendered = renderer.render();
  if(debug) {
    print('Rendered index: $rendered');
  }
  file.writeAsStringSync(rendered);
}