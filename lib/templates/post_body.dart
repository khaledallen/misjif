postBody(Map<String, dynamic> data) {
  return '''<article>
              <h3 class="post-date">${data['date']}</h3>
              <h1 class="post-title">${data['title']}</h1>
              <div class="post-image">
                ${_postImage(data['image'])}
              </div>
              <div class="post-body">
                ${data['content']}
              </div>
            </article>''';
}

_postImage(image) {
  if (image != '') return '<img src="../images/$image" />';
  return '';
}
