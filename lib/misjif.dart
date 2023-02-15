import 'dart:async';
import 'dart:io';
import 'post.dart';
import 'templates/index.dart';
import 'templates/post.dart';


Future<void> generatePostFile(Post post, {bool debug = false}) async {
  String newName = post.path.split('/')[1].split('.')[0];
  try {
    var file = await File('public/posts/$newName.html').create(recursive: true);
    var data = {
      'title': post.title,
      'date': post.getFormattedDate(),
      'content': post.content
    };
    var rendered = postTemplate(data);
    file.writeAsStringSync(rendered);
  } catch (e) {
    print('Error generating post file: $e');
  }
}

void processPosts(String dir) {
  var postDirectory = Directory(dir);
  var posts = postDirectory.listSync();
  List<Post> postList = [];
  for(var file in posts) {
    if(file.path.contains('.md')) {
      Post post = Post(file.path);
      postList.add(post);
      generatePostFile(post);
    }
  }
  generateIndex(postList, debug: true);

}

Future<void> generateIndex(List<Post> postList, {bool debug = false}) async {
  var file = await File('public/index.html').create(recursive: true);
  Map<String, dynamic> data = {
    'title': 'main page',
    'postList': postList,
  };
  var rendered = index(data);
  if(debug) {
    print('Rendered index: $rendered');
  }
  file.writeAsStringSync(rendered);
}