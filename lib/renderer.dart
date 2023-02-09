import 'post.dart';

class Renderer {
  List<String> parsed;
  Map<dynamic, dynamic> postData;

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

  String insertData(token) {
    var prop = token.replaceAll(RegExp('{{|}}'), '')
      .trim().split('.')[1];
    try {
      print(postData[prop]);
      return postData[prop];
    } catch (e) {
      print('Property $prop not defined on this post type: $e');
    }
    return token;
  }
}