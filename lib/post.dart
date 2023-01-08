import 'dart:io';
import 'package:markdown/markdown.dart';

class Post {
  late String title;
  late DateTime date;
  late String content;
  bool draft = true;
  String path;

  Post(this.path) {
    List<String> markdownString = File(path).readAsLinesSync();

    Map metadata = parseYaml(markdownString);
    title = metadata['title'].trim();
    date = DateTime.parse(metadata['date'].trim());
    draft = metadata['draft'] != 'false' ? false : draft;
    content = parseHtml(markdownString);
  }

  String getFormattedDate() {
    Map<int, String> months = {
      1: 'January',
      2: 'February',
      3: 'March',
      4: 'April',
      5: 'May',
      6: 'June',
      7: 'July',
      8: 'August',
      9: 'September',
      10: 'October',
      11: 'November',
      12: 'December',
    };

    return '${months[date.month]} ${date.day}, ${date.year}';
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
