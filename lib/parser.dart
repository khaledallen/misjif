import 'dart:io';

enum StatementType {
  include,
  forloop,
  endforloop,
  templateVar,
  html,
}

class Statement {
  StatementType statementType;
  String statementBody;
  Statement(this.statementType, this.statementBody);
}

class Parser {
  String template;
  int current = 0;
  int last = 0;
  List<Statement> parsed = [];

  Parser(this.template);

  List<Statement> parse() {
    while(template.length > current) {
      if(isStatement()) {
        // Add the template up to this point.
        parsed.add(Statement(StatementType.html, template.substring(last, current)));
        last = current;
        current += 2;
        parseStatement();
      }
      current++;
    }
    parsed.add(Statement(StatementType.html, template.substring(last, current)));
    return parsed;
  }

  bool isStatement() {
    return (template[current] == '{' && template[current+1] == '{');
  }
  
  bool isInclude(String s) {
    return s.indexOf('include') == 0;
  }

  bool isForLoop(String s) {
    return s.indexOf('for') == 0;
  }

  void parseStatement() {
    // Move past the opening braces.
    while(template[current] == '{') {
      current++;
      last++;
    }
    // Move current pointer to closing braces.
    while(!(template[current + 1] == '}' &&
     template[current + 2] == '}')) {
      current++;
    }

    String statementBody = template.substring(last,current).trim();

    // Step past the closing braces.
    while(template[current] == '}' || template[current + 1] == '}') {
      current++;
    }
    last = current;

    if(isInclude(statementBody)){
      include(statementBody);
      return;
    } 
    if(isForLoop(statementBody)) {
      forLoop(statementBody);
      return;
    }
    parsed.add(Statement(StatementType.templateVar, statementBody));
  }

  void include(String statement) {
    String name = statement
      .replaceAll(RegExp('{{|}}'), '')
      .trim()
      .split(' ')[1]
      .replaceAll('"', '');
    String template = File('templates/$name.html').readAsStringSync();

    Parser parser = Parser(template);
    parsed.addAll(parser.parse());
  }

  void forLoop(String statement) {
    return;
  }
}