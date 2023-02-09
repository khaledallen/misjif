import 'dart:io';

class Parser {
  String template;
  int current = 0;
  int last = 0;
  List<String> parsed = [];

  Parser(this.template);

  List<String> parse() {
    while(template.length > current) {
      if(isStatement()) {
        parsed.add(template.substring(last, current));
        last = current;
        current += 2;
        parseStatement();
      }
      current++;
    }
    parsed.add(template.substring(last, current));
    return parsed;
  }

  bool isStatement() {
    return (template[current] == '{' && template[current+1] == '{');
  }

  void parseStatement() {
    while(!(template[current] == '}' && template[current - 1] == '}')) {
      current++;
    }
    String statementBody = template.substring(last,++current);
    last = current;
    current += 2;
    if(statementBody.contains('include')) {
      parseInclude(statementBody);
    } else {
      parsed.add(statementBody);
    }
  }

  void parseInclude(String statement) {
    String name = statement
      .replaceAll(RegExp('{{|}}'), '')
      .trim()
      .split(' ')[1]
      .replaceAll('"', '');
    String template = File('templates/$name.html').readAsStringSync();

    Parser subparser = Parser(template);
    parsed.addAll(subparser.parse());
  }
}