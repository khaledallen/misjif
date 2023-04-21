import 'package:misjif/globals.dart';

/* Builds the navbar once and returns it when called. */

String navbar = '';

getNav() {
  return navbar;
}

renderNavbar(Map<String, dynamic> data) {
  if (navbar == '') {
    navbar = '''
    <div class="navbar">
      ${_generateNav(data['pageList'])}
    </div>
  ''';
  }
}

_generateNav(pageList) {
  for (var page in pageList) {
    return '<a href="$rootPath/page/${page.getFilename()}.html">${page.title}</a>';
  }
}
