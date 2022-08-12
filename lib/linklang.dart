int calculate() {
  return 6 * 7;
}

int nextID = 0;

Map<String, List<int>> vars = {};

class Cell {
  String id;
  int rot;
  Map<String, int> data;

  Cell(this.id, this.rot, this.data);
}

class Grid {
  Map<String, Cell> cells = {};

  void assembleStruct(Map<String, Cell> structure, int x, int y) {
    structure.forEach((key, cell) {
      final cx = int.parse(key.split(" ").first);
      final cy = int.parse(key.split(" ")[1]);

      cells["${cx + x} ${cy + y}"] = cell;
    });
  }
}
