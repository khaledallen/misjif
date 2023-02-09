import 'post.dart';

class Renderer {
  List<String> parsed;
  Post postData;

  Renderer(this.parsed, this.postData);

  render() {
    for (int i = 0; i < parsed.length; i++) {
      var token = parsed[i];
      if(token.contains('{{')) {
        parsed[i] = insertData(token);
      }
    }
    print(parsed);
    return parsed.join();
  }

  insertData(token) {
    var prop = token.replaceAll(RegExp('{{|}}'), '')
      .trim().split('.')[1];
    print(prop);
    switch (prop) {
      case 'title':
        return postData.title; 
      case 'date':
        return postData.getFormattedDate();
      case 'content':
        return postData.content; 
      default:
        print('No property $token defined on Posts.');
    }
    return token;
  }
}