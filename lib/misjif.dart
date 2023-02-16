import 'dart:async';
import 'dart:io';
import 'post.dart';
import 'templates/index.dart';
import 'templates/post.dart';
import 'globals.dart';
import 'package:sass/sass.dart' as sass;

List<Post> postList = [];

void buildSite(String dir) {
  processPosts(dir);
  generateIndex(postList);
  compileSass();
}

Future<void> generatePostFile(Post post, {bool debug = false}) async {
  String newName = post.path.split('/')[1].split('.')[0];
  try {
    var file = await File('$rootPath/posts/$newName.html').create(recursive: true);
    var data = {
      'title': post.title,
      'date': post.getFormattedDate(),
      'content': post.content,
      'image': post.image,
      'rootPath': rootPath
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
  for(var file in posts) {
    if(file.path.contains('.md')) {
      Post post = Post(file.path);
      postList.add(post);
      generatePostFile(post);
    }
  }
}

Future<void> generateIndex(List<Post> postList, {bool debug = false}) async {
  var file = await File('public/index.html').create(recursive: true);
  postList.sort((a, b) => b.date.compareTo(a.date));
  print(postList);
  Map<String, dynamic> data = {
    'title': 'main page',
    'postList': postList,
    'rootPath': rootPath,
  };
  var rendered = index(data);
  if(debug) {
    print('Rendered index: $rendered');
  }
  file.writeAsStringSync(rendered);
}

compileSass() {
  var result = sass.compileToResult('scss/styles.scss');
  File('public/styles/style.css').writeAsStringSync(result.css);
}