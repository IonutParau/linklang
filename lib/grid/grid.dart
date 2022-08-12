import 'package:linklang/grid/pos.dart';

import 'package:linklang/grid/cell.dart';

class Grid {
  Map<CellPos, Cell> cells = {};

  void set(int x, int y, Cell cell) {
    cells[CellPos(x, y)] = cell;
  }

  Cell get(int x, int y) {
    return cells[CellPos(x, y)] ?? Cell(0, 0, []);
  }

  void build(int x, int y, Map<CellPos, Cell> build) {
    build.forEach((position, cell) {
      set(x + position.x, y + position.y, cell);
    });
  }
}
