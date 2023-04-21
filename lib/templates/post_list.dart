import 'package:misjif/globals.dart';

String postListString = '';

String getPostList() {
  return postListString;
}

renderPostList(data) {
  if (postListString == '') {
    List<String> arr = [];
    arr.add('<ul>');
    for (var post in data['postList']) {
      String pathName = post.path.split('/')[2].split('.')[0];
      arr.add(
          '<li><a href="$rootPath/posts/$pathName.html">${post.title}</a></li>');
    }
    arr.add('</ul>');
    postListString = '<h4>Recent Posts</h4>${arr.join()}';
  }
}
