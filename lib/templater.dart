import 'dart:io';
import 'post.dart';

String insertIncludes(String template, Post post) {
    RegExp regExp = RegExp(r'{{\s*([a-zA-z." ]*)\s*}}');
    template = template.replaceAllMapped(regExp, (match) => insert(match[1], post)); 
    return template;
}

insert(String? m, Post post) {
  if(m != null && m.isNotEmpty) {
    String command = m.trim();
    if(command.contains('include')) {
      String filename = getFilename(command);
      String filler = File('templates/$filename.html').readAsStringSync();
      return filler;
    }

    if(command.contains('post.')) {
      final parts = command.split('.');
      if(parts[0] != 'post') print('What is ${parts[0]}?');
      final prop = parts[1];
      switch(prop) {
        case 'title':
          return post.title;
        case 'date':
          return post.getFormattedDate();
        case 'content':
          return post.content;
      }
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

String buildPost(Post post) {
  var postTemplate = File('templates/post.html').readAsStringSync();
  postTemplate = insertIncludes(postTemplate, post);
  return postTemplate;
}
