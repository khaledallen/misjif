import 'post.dart';

class Renderer {
  List<String> parsed;
  Map<dynamic, dynamic> postData;

  Renderer(this.parsed, this.postData);

  render() {
    for (int i = 0; i < parsed.length; i++) {
      print('1');
      var token = parsed[i];
      print(token);
      if(token.contains('{{')) {
        parsed[i] = insertData(token);
      }
    }
    return parsed.join();
  }

  String insertData(token) {
    var prop = token.replaceAll(RegExp('{{|}}'), '')
      .trim().split('.')[1];
    try {
      return postData[prop];
    } catch (e) {
      print('Property $prop not defined on this post type: $e');
    }
    return token;
  }
}