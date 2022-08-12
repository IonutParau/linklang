import 'package:linklang/compiler/allocation_manager.dart';
import 'package:linklang/compiler/tokens/constant.dart';
import 'package:linklang/compiler/tokens/import_file.dart';
import 'package:linklang/compiler/tokens/token.dart';

/*

How errors are named: Parsing error is when the syntax is invalid
Tokenization error is when you try to do something that defies logic

*/

List<String> parseLine(String line, [String sep = " "]) {
  final l = [""];
  var depth = 0;
  var instring = false;

  for (var char in line.split("")) {
    if (char == "\"") instring = !instring;

    if (instring || char == "\"") {
      l.last += char;
      continue;
    }
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

List<String> removeWhitespace(List<String> list) {
  for (var i = 0; i < list.length; i++) {
    while (list[i].startsWith(' ') || list[i].startsWith('\t')) {
      list[i] = list[i].substring(1);
    }
  }

  return list;
}

Token parseAsToken(List<String> parsedLine, int line, bool topLevel) {
  while (parsedLine[0].startsWith(' ') || parsedLine[0].startsWith('\t')) {
    parsedLine[0] = parsedLine[0].substring(1);
  }
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

    if (parsedLine.first.startsWith('"') && parsedLine.first.endsWith('"')) {
      return ImportFile(parsedLine.first.substring(1, parsedLine.first.length - 1));
    }

    if (parsedLine.first.contains('(') && parsedLine.first.endsWith(')')) {
      //if (topLevel) throw "Tokenization Error: Attempt to call a function at top-level. This would cause memory waste";
      final startOfParams = parsedLine.first.indexOf('(');
      final name = parsedLine.first.substring(0, startOfParams);
      final returnReference = AllocationManager.availableReference;
      final params = removeWhitespace(parseLine(parsedLine.first.substring(startOfParams + 1, parsedLine.first.length - 1), ","));

      final paramTokens = params.map<Token>((e) => parseAsToken(parseLine(e), line, false)).toList();

      return CallFunction(name, returnReference, paramTokens);
    }

    if (parsedLine.first == "flow" || parsedLine.first == "noflow") {
      return Constant(parsedLine.first == "flow");
    }
  }

  throw "Parsing Failure: Unknown syntax at line $line";
}
