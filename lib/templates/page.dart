import 'head.dart';
import 'header.dart';
import 'footer.dart';

pageTemplate(Map<String, dynamic> data) {
  return '''
  <!DOCTYPE html>
  <html>
    ${head()}
    <body>
      ${header()}
      <main class="container">
        <div class="column">
          <article>
            <h1 class="page-title">${data['title']}</h1>
            <div class="page-body">
              ${data['content']}
            </div>
          </article>
        </div>
      </main>
      ${footer()}
    </body>
  </html>
  ''';
}
