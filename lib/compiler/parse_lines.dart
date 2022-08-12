import 'package:linklang/compiler/tokens/token.dart';

List<String> parseLine(String line, [String sep = " "]) {
  final l = [""];
  var depth = 0;

  for (var char in line.split("")) {
    if (char == "(") {
      depth++;
    }
    if (char == ")") {
      depth--;
    }

    if (char == sep && depth == 0) {
      l.add("");
    } else {
      l.last += char;
    }
  }

  return l;
}

Token parseAsToken(List<String> parsedLine) {
  throw "Unknown Syntax";
}
