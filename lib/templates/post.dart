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
      <main class="container">
        <div class="column">
          <article>
            <h3 class="post-date">${data['date']}</h3>
            <h1 class="post-title">${data['title']}</h1>
            <div class="post-image">
              ${_postImage(data['image'])}
            </div>
            <div class="post-body">
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

_postImage(image) {
  if(image != '') return '<img src="../images/$image />';
  return '';
}