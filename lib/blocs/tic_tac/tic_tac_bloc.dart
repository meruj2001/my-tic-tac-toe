import 'package:bloc/bloc.dart';
import 'package:flutter_tic_tac_toe/models/enums/player.dart';
import 'package:meta/meta.dart';

part 'tic_tac_event.dart';

part 'tic_tac_state.dart';

class TicTacBloc extends Bloc<TicTacEvent, TicTacState> {
  TicTacBloc() : super(TicTacState.empty()) {
    on<TicTacEvent>(
      (event, emit) {
        if (event is PressedXEvent) {
          emit(_onEvent(event.i, event.j, PlayerAction.x));
        }

        if (event is PressedOEvent) {
          emit(_onEvent(event.i, event.j, PlayerAction.o));
        }

        if (event is ResetEvent) {
          emit(TicTacState.empty());
        }
      },
    );
  }

  TicTacState _onEvent(int i, int j, PlayerAction action) {
    final mustPlay = state.mustPlay == PlayerAction.x ? PlayerAction.o : PlayerAction.x;
    final newState = TicTacState(metrix: state.metrix, mustPlay: mustPlay, winPlayer: PlayerAction.empty, noWinner: false);
    newState.metrix[i][j] = action;
    newState.winPlayer = _winner(i, j, action);
    newState.noWinner = _noWinner();
    return newState;
  }

  PlayerAction _winner(int i, int j, PlayerAction player) {
    var col = 0, row = 0, diag = 0, rdiag = 0;
    final n = state.metrix.length;

    for (int k = 0; k < n; k++) {
      if (state.metrix[i][k] == player) col++;
      if (state.metrix[k][j] == player) row++;
      if (state.metrix[k][k] == player) diag++;
      if (state.metrix[k][n - k - 1] == player) rdiag++;
    }

    if (col == n || row == n || diag == n || rdiag == n) {
      return player;
    }

    return PlayerAction.empty;
  }

  bool _noWinner() {
    bool isNoWinner = true;
    for (var listOfActions in state.metrix) {
      for (var action in listOfActions) {
        if (action == PlayerAction.empty) {
          isNoWinner = false;
        }
      }
    }
    return isNoWinner;
  }
}
