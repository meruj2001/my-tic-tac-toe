part of 'tic_tac_bloc.dart';

class TicTacState {
  List<List<PlayerAction>> metrix;
  PlayerAction mustPlay;
  PlayerAction winPlayer;
  bool noWinner;

  TicTacState({required this.metrix, required this.mustPlay, required this.winPlayer, required this.noWinner});

  static empty() => TicTacState(
        metrix: List.generate(3, (index) => List.generate(3, (index) => PlayerAction.empty)),
        mustPlay: PlayerAction.o,
        winPlayer: PlayerAction.empty,
        noWinner: false,
      );
}
