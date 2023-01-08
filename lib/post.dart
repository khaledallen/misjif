import 'dart:io';
import 'package:markdown/markdown.dart';

class Post {
  late String title;
  late DateTime date;
  late String content;
  bool draft = true;

  Post(String path) {
    List<String> markdownString = File(path).readAsLinesSync();

    Map metadata = parseYaml(markdownString);
    title = metadata['title'].trim();
    date = DateTime.parse(metadata['date'].trim());
    draft = metadata['draft'] != 'false' ? false : draft;
    content = parseHtml(markdownString);
  }

  MapEntry buildPostMeta(String line) {
    var meta = line.split(':');
    return MapEntry(meta[0], meta[1]);
  }

  Map parseYaml(List<String> markdown) {
    var metaItems = markdown
        .skipWhile((line) => line == '---')
        .takeWhile((line) => line != '---')
        .map((line) => buildPostMeta(line));
    return Map.fromEntries(metaItems);
  }

  String parseHtml(List<String> markdown) {
    var htmlItems = markdown
        .skipWhile((line) => line == '---')
        .skipWhile((line) => line != '---')
        .skip(1)
        .map((line) => markdownToHtml(line));

    return htmlItems.join('');
  }
}
