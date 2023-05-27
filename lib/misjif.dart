import 'dart:async';
import 'dart:io';
import 'post.dart';
import 'page.dart';
import 'templates/post_list.dart';
import 'templates/index.dart';
import 'templates/post.dart';
import 'templates/page.dart';
import 'templates/nav.dart';
import 'globals.dart';
import 'package:sass/sass.dart' as sass;

List<Post> postList = [];
List<Page> pageList = [];

void buildSite(String dir) async {
  await Directory('public/styles').create(recursive: true);
  generatePostList(dir);
  generatePageList(dir);
  processImages(dir);
  renderNavbar({'pageList': pageList});
  renderPostList({'postList': postList});
  for (var page in pageList) {
    generatePageFile(page);
  }
  for (var post in postList) {
    generatePostFile(post);
  }
  generateIndex();
  compileSass();
}

Future<void> generatePostFile(Post post, {bool debug = false}) async {
  print('Generating post file: ${post.getFilename()}');
  try {
    var file = await File('public/posts/${post.getFilename()}.html')
        .create(recursive: true);
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

void generatePostList(String dir) {
  var postDirectory = Directory('$dir/posts');
  var posts = postDirectory.listSync();
  for (var file in posts) {
    if (file.path.contains('.md')) {
      Post post = Post(file.path);
      postList.add(post);
    }
  }
}

Future<void> generatePageFile(Page page, {bool debug = false}) async {
  try {
    var file = await File('public/page/${page.getFilename()}.html')
        .create(recursive: true);
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

void generatePageList(String dir) {
  var pageDirectory = Directory('$dir/pages');
  var pages = pageDirectory.listSync();
  for (var file in pages) {
    if (file.path.contains('.md')) {
      Page page = Page(file.path);
      pageList.add(page);
    }
  }
}

Future<void> generateIndex({bool debug = false}) async {
  var file = await File('public/index.html').create(recursive: true);
  postList.sort((a, b) => b.date.compareTo(a.date));
  print(postList);
  Map<String, dynamic> data = {
    'title': 'main page',
    'postList': getPostList(),
    'rootPath': rootPath,
  };
  var rendered = index(data);
  if (debug) {
    print('Rendered index: $rendered');
  }
  file.writeAsStringSync(rendered);
}

void processImages(String dir) async {
  var publicImgDir = await Directory('public/images/').create(recursive: true);
  var imgFiles = Directory('$dir/images/').listSync();
  for (var file in imgFiles) {
    var filename = file.path.substring(file.path.lastIndexOf('/') + 1);
    File(file.path).copy('${publicImgDir.path}$filename');
  }
}

compileSass() {
  var result = sass.compileToResult('scss/styles.scss');
  File('public/styles/style.css').writeAsStringSync(result.css);
}
