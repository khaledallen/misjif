import 'dart:async';
import 'dart:io';
import 'post.dart';
import 'page.dart';
import 'templates/index.dart';
import 'templates/post.dart';
import 'templates/page.dart';
import 'globals.dart';
import 'package:sass/sass.dart' as sass;

List<Post> postList = [];
List<Page> pageList = [];

void buildSite(String dir) async {
  await Directory('public/styles').create(recursive: true);
  processPosts(dir);
  processPages(dir);
  generateIndex(postList);
  compileSass();
}

Future<void> generatePostFile(Post post, {bool debug = false}) async {
  String newName = post.path.split('/')[2].split('.')[0];
  try {
    var file =
        await File('$rootPath/posts/$newName.html').create(recursive: true);
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
  var postDirectory = Directory('$dir/posts');
  var posts = postDirectory.listSync();
  for (var file in posts) {
    if (file.path.contains('.md')) {
      Post post = Post(file.path);
      postList.add(post);
      generatePostFile(post);
    }
  }
}

Future<void> generatePageFile(Page page, {bool debug = false}) async {
  print(page.path);
  String newName = page.path.split('/')[2].split('.')[0];
  print(newName);
  try {
    var file = await File('$rootPath/$newName.html').create(recursive: true);
    var data = {
      'title': page.title,
      'content': page.content,
      'rootPath': rootPath
    };
    var rendered = pageTemplate(data);
    file.writeAsStringSync(rendered);
  } catch (e) {
    print('Error generating page file: $e');
  }
}

void processPages(String dir) {
  var pageDirectory = Directory('$dir/pages');
  var pages = pageDirectory.listSync();
  for (var file in pages) {
    if (file.path.contains('.md')) {
      Page page = Page(file.path);
      pageList.add(page);
      generatePageFile(page);
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
  if (debug) {
    print('Rendered index: $rendered');
  }
  file.writeAsStringSync(rendered);
}

compileSass() {
  var result = sass.compileToResult('scss/styles.scss');
  File('public/styles/style.css').writeAsStringSync(result.css);
}
