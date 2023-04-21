import 'dart:io';
import 'package:markdown/markdown.dart';

class Page {
  late String title;
  late DateTime date;
  late String content;
  late String image;
  bool draft = true;
  String path;

  Page(this.path) {
    List<String> markdownString = File(path).readAsLinesSync();

    Map metadata = parseYaml(markdownString);
    title = metadata['title'].trim();
    date = DateTime.parse(metadata['date'].trim());
    draft = metadata['draft'] != 'false' ? false : draft;
    image = metadata['image'] != null ? metadata['image'].trim() : '';
    content = generateHtmlFromMarkdown(markdownString);
  }

  String getFilename() {
    return path.split('/')[2].split('.')[0];
  }

  MapEntry buildPageMeta(String line) {
    var meta = line.split(':');
    return MapEntry(meta[0], meta[1]);
  }

  Map parseYaml(List<String> markdown) {
    var metaItems = markdown
        .skipWhile((line) => line == '---')
        .takeWhile((line) => line != '---')
        .map((line) => buildPageMeta(line));
    return Map.fromEntries(metaItems);
  }

  String generateHtmlFromMarkdown(List<String> markdown) {
    var htmlItems = markdown
        .skipWhile((line) => line == '---')
        .skipWhile((line) => line != '---')
        // .skip(1)
        .map((line) => markdownToHtml(line));

    return htmlItems.join('');
  }
}
