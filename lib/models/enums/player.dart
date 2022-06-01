enum PlayerAction {
  empty,
  x,
  o
}

extension PlayerActionExtension on PlayerAction {
  String get value {
    switch (this) {
      case PlayerAction.empty:
        return "";
      case PlayerAction.x:
        return "o";
      case PlayerAction.o:
        return "x";
    }
  }
}