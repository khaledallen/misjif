
MapEntry buildPostMeta(String line) {
  var meta = line.split(':');
  return MapEntry(meta[0], meta[1]);
}

Map parseYaml(List<String> markdown) {
  var metaItems = markdown.skipWhile((line) => line == '---')
      .takeWhile((line) => line != '---')
      .map((line) => buildPostMeta(line));
  return Map.fromEntries(metaItems);
}