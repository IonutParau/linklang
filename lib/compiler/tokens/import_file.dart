import 'package:linklang/compiler/tokens/token.dart';

class ImportFile extends Token {
  String name;
  ImportFile(this.name);
}
