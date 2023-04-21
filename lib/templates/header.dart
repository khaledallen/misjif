import 'package:misjif/globals.dart';
import '../templates/nav.dart';

header() {
  return '''
    <div class="navbar">
      <h4 class="home-link"><a href="$rootPath/index.html">Home</a></h4>
      ${getNav()}
    </div>
  ''';
}
