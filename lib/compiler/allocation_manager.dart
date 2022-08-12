class AllocationManager {
  static Map<String, List<int>> variableReferenceKeys = {};

  static int _nextReturnReference = 0;
  static int _nextVariableReference = 0;

  static int get availableReturnReference {
    return _nextReturnReference++;
  }

  static void addVariableReference(String variable) {
    if (variableReferenceKeys[variable] == null) {
      variableReferenceKeys[variable] = <int>[];
    }

    variableReferenceKeys[variable]?.add(_nextVariableReference++);
  }

  static bool isVariable(String variable) => variableReferenceKeys.containsKey(variable);
}
