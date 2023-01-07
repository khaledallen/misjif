import 'dart:async';
import 'dart:io';
import 'package:markdown/markdown.dart';

MapEntry buildPostMeta(String line) {
  var meta = line.split(':');
  return MapEntry(meta[0], meta[1]);
}

String renderHtml(String path) {
  List<String> markdown = File(path).readAsLinesSync();

  var metaItems = markdown
      .skipWhile((line) => line == '---')
      .takeWhile((line) => line != '---')
      .map((line) => buildPostMeta(line));

  var htmlItems = markdown
      .skipWhile((line) => line == '---')
      .skipWhile((line) => line != '---')
      .skip(1)
      .map((line) => markdownToHtml(line));

  Map postMetadata = Map.fromEntries(metaItems);
  var htmlString = htmlItems.join('');
  var postTemplate = File('templates/post.html').readAsStringSync();
  postTemplate = postTemplate.replaceAll(
      RegExp(r'{{ post.title }}'), postMetadata['title']);
  postTemplate = postTemplate.replaceAll(RegExp(r'{{ post }}'), htmlString);
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