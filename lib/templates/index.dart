import 'head.dart';
import 'header.dart';
import 'footer.dart';
import 'post_body.dart';

index(data) {
  return '''
    <!DOCTYPE html>
    <html>
      ${head()}
      <body>
        ${header()}
        <div class="container">
          <main>
          ${postBody({
        'content': data['latestPost'].content,
        'title': data['latestPost'].title,
        'date': data['latestPost'].date,
        'image': data['latestPost'].image,
      })}
          </main>
          <div class="column sidebar">
            <div class="post-list">
              <ul>
                ${data['postList']}
              </ul>
            </div>
          </div>
        </div>
        ${footer()}
      </body>
    </html>
    ''';
}
