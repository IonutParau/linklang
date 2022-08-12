import 'package:linklang/compiler/allocation_manager.dart';
import 'package:linklang/compiler/tokens/token.dart';

/*

How errors are named: Parsing error is when the syntax is invalid
Tokenization error is when you try to do something that defies logic

*/

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

Token parseAsToken(List<String> parsedLine, int line, bool topLevel) {
  if (parsedLine.length == 3) {
    if (parsedLine[1] == ">") {
      if (!parsedLine[2].startsWith('\$')) {
        throw "Tokenization Error: Attempt to link to non-variable at line $line";
      }
      if (!AllocationManager.isVariable(parsedLine[2])) {
        throw "Tokenization Error: Attempt to link to non-existant variable";
      }
      return VariableLink(parsedLine[2], parseAsToken([parsedLine[0]], line, false));
    }
  }

  if (parsedLine.length == 1) {
    if (parsedLine.first.startsWith('\$')) {
      if (AllocationManager.isVariable(parsedLine.first)) {
        if (topLevel) throw "Tokenization Error: Attempt to declare duplicate variable at line $line";
        AllocationManager.addVariableReference(parsedLine.first);
        return VariableGet(parsedLine.first);
      } else {
        if (!topLevel) throw "Tokenization Error: Attempt to declare variable inside of paramaters at line $line";
        AllocationManager.declareVariable(parsedLine.first);
        return VariableDeclare(parsedLine.first);
      }
    }
  }

  throw "Parsing Failure: Unknown syntax at line $line";
}
