import 'dart:math';

class CellPos {
  int x, y;

  CellPos(this.x, this.y);

  @override
  bool operator ==(Object other) {
    if (other is! CellPos) return false;
    return other.x == x && other.y == y;
  }

  CellPos operator +(CellPos other) {
    return CellPos(x + other.x, y + other.y);
  }

  CellPos operator -(CellPos other) {
    return CellPos(x - other.x, y - other.y);
  }

  @override
  int get hashCode => pow(x, 1000).toInt() + pow(y, 10000).toInt();
}
