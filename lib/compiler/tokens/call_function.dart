import 'package:linklang/compiler/tokens/token.dart';

class CallFunction extends Token {
  String function;
  int returnReference;
  List<Token> params;

  CallFunction(this.function, this.returnReference, this.params);
}
