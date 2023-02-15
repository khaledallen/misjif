import 'head.dart';
import 'header.dart';
import 'footer.dart';
import '/post.dart';

index(data){
  return '''
    <!DOCTYPE html>
    <html>
      ${head()}
      <body>
        ${header()}
        <div class="column">
          <h1 id="Main Page"></h1>
          <div class="post-list">
            <ul>
              ${_generatePostList(data['postList'])}
            </ul>
          </div>
        </div>
        ${footer()}
      </body>
    </html>
    ''';
}

_generatePostList(postList) {
  List<String> arr = [];
  for(Post post in postList) {
    String pathName = post.path.split('/')[1].split('.')[0];
    arr.add('<li><a href="posts/$pathName.html">${post.title}</a></li>');
  }
  return arr.join();
}