import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tic_tac_toe/blocs/tic_tac/tic_tac_bloc.dart';
import 'package:flutter_tic_tac_toe/models/enums/player.dart';
import 'package:flutter_tic_tac_toe/shared/utils.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext cContext) {
    return BlocProvider(
      create: (context) => TicTacBloc(),
      child: BlocBuilder<TicTacBloc, TicTacState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Tic Tac Toe"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.restart_alt_rounded),
                  onPressed: () {
                    BlocProvider.of<TicTacBloc>(context).add(ResetEvent());
                  },
                )
              ],
            ),
            body: BlocListener<TicTacBloc, TicTacState>(
              listener: (context, state) {
                if (state.winPlayer != PlayerAction.empty) {
                  _showEndDialog(context, "Player ${state.winPlayer.value} win!", BlocProvider.of<TicTacBloc>(context));
                } else if (state.noWinner) {
                  _showEndDialog(context, "No Winner", BlocProvider.of<TicTacBloc>(context));
                }
              },
              child: Container(
                color: state.mustPlay == PlayerAction.x ? Colors.blue[200] : Colors.red[200],
                child: Center(child: _buildItems(context, state)),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildItems(context, TicTacState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: Utils.modelBuilder(
        state.metrix,
        (indexRow, List<PlayerAction> model) => Row(
          mainAxisSize: MainAxisSize.min,
          children: Utils.modelBuilder(
            model,
            (index, PlayerAction action) => Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                width: 90,
                height: 90,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: action == PlayerAction.empty
                          ? Colors.white
                          : action == PlayerAction.x
                              ? Colors.blue
                              : Colors.red),
                  onPressed: () {
                    if (action == PlayerAction.empty) {
                      state.mustPlay == PlayerAction.x
                          ? BlocProvider.of<TicTacBloc>(context).add(PressedXEvent(i: indexRow, j: index))
                          : BlocProvider.of<TicTacBloc>(context).add(PressedOEvent(i: indexRow, j: index));
                    }
                  },
                  child: Text(
                    action.value,
                    style: const TextStyle(color: Colors.white, fontSize: 32),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _showEndDialog(BuildContext context, String title, TicTacBloc bloc) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text(title),
          actions: [
            ElevatedButton(
                onPressed: () {
                  bloc.add(ResetEvent());
                  Navigator.pop(context);
                },
                child: const Text("Restart"))
          ],
        ),
      );
}
