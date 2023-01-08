import 'dart:io';
import 'post.dart';

String insertIncludes(String template) {
    RegExp regExp = RegExp(r'{{\s*([a-zA-z." ]*)\s*}}');
    template = template.replaceAllMapped(regExp, (match) => include(match[0])); 
    return template;
}

include(String? m) {
  if(m != null && m.isNotEmpty) {
    String command = m;
    if(command.contains('include')) {
      String filename = getFilename(command);
      String filler = File('templates/$filename.html').readAsStringSync();
      return filler;
    }

    if(command.contains('post.')) {
      print(command);
    }
  }
  return '';
}

String getFilename(String command) {
  int start = -1;
  int end = -1;
  for(int i = 0; i < command.length; i++) {
    if(command[i] == '"') {
      if(start < 0) {start = i + 1;}
      else {end = i;}
    }
  }
  return command.substring(start, end);
}

String insertPost(String postTemplate, Post post) {
  print(postTemplate);
  print(post.title);
  postTemplate = postTemplate.replaceAll(RegExp(r'{{ post.title }}'), post.title);
  postTemplate = postTemplate.replaceAll(RegExp(r'{{ post.content }}'), post.content);
  return postTemplate;
}

String buildPost(Post post) {
  var postTemplate = File('templates/post.html').readAsStringSync();
  postTemplate = insertPost(postTemplate, post);
  postTemplate = insertIncludes(postTemplate);
  return postTemplate;
}
