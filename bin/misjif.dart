import 'package:misjif/misjif.dart' as misjif;

void main(List<String> arguments) {
  misjif.printPostToConsole(arguments[0]);
  misjif.generatePostFile(arguments[0]);
}
