class AllocationManager {
  static Map<String, List<int>> variableReferenceKeys = {};

  static int _nextReference = 0;

  static int get availableReference {
    return _nextReference++;
  }

  static void addVariableReference(String variable) {
    if (variableReferenceKeys[variable] == null) {
      variableReferenceKeys[variable] = <int>[];
    }

    variableReferenceKeys[variable]?.add(availableReference);
  }

  static bool isVariable(String variable) => variableReferenceKeys.containsKey(variable);

  static void declareVariable(String name) {
    variableReferenceKeys[name] = [availableReference];
  }
}
