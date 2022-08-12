import 'package:linklang/compiler/tokens/token.dart';

class VariableLink extends Token {
  String variableToLink;
  Token expression;

  VariableLink(this.variableToLink, this.expression);
}
