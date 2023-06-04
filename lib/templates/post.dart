import 'head.dart';
import 'header.dart';
import 'footer.dart';
import 'post_list.dart';
import 'post_body.dart';

postTemplate(Map<String, dynamic> data) {
  return '''
  <!DOCTYPE html>
  <html>
    ${head()}
    <body>
      ${header()}
      <div class="container">
        <main>
          <div class="column">
            ${postBody(data)}
          </div>
        </main>
        <div class="sidebar">
          ${getPostList()}
        </div>
      </div>
      ${footer()}
    </body>
  </html>
  ''';
}
