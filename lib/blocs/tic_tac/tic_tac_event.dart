part of 'tic_tac_bloc.dart';

@immutable
abstract class TicTacEvent {}

class PressedXEvent extends TicTacEvent {
  final int i;
  final int j;

  PressedXEvent({required this.i, required this.j});
}
class PressedOEvent extends TicTacEvent {
  final int i;
  final int j;

  PressedOEvent({required this.i, required this.j});
}

class ResetEvent extends TicTacEvent {}
