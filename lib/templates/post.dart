import 'head.dart';
import 'header.dart';
import 'footer.dart';

postTemplate(Map<String, dynamic> data) {
  return '''
  <!DOCTYPE html>
  <html>
    ${head()}
    <body>
      ${header()}
      <div class="column">
        <h1 id = "headHeader"></h1>
        <h1>${data['title']}</h1>
        <h3>${data['date']}</h3>
        <div class="post-body">
          ${data['content']}
        </div>
      </div>
      ${footer()}
    </body>
  </html>
  ''';
}