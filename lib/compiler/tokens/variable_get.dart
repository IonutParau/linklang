import 'package:linklang/compiler/tokens/token.dart';

// Token for when getting a variable. Useful for allocating
class VariableGet extends Token {
  String variable;

  VariableGet(this.variable);
}
