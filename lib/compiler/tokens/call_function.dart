import 'package:linklang/compiler/tokens/token.dart';

class CallFunction extends Token {
  String function;
  List<Token> params;

  CallFunction(this.function, this.params);
}
