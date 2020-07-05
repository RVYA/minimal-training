import 'package:flutter/foundation.dart' show required;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe_package/src/models/tictactoe_player.dart';

import '../widgets/tictactoe_cell.dart';


abstract class PlayerEvent {
  const PlayerEvent({
    @required this.markedCellIndex,
    @required this.playerMark,
  });

  final int markedCellIndex;
  final PlayerMark playerMark;
}

class PlayerPlayed extends PlayerEvent {
  const PlayerPlayed({
    @required int markedCellIndex,
    @required PlayerMark playerMark,
  })
  : super(
      markedCellIndex: markedCellIndex,
      playerMark     : playerMark,
    );
}

class PlayerWon extends PlayerEvent {}


const int _kTicTacToeCellCount = 9;

class TicTacToeGridBloc extends Bloc<PlayerEvent, List<CellState>> {
  @override
  List<CellState> get initialState {
    return List<CellState>
            .filled(_kTicTacToeCellCount, CellState.empty);
  }

  @override
  Stream<List<CellState>> mapEventToState(PlayerEvent event) async* {
    if (event is PlayerPlayed) {
      final List<CellState> newState = List<CellState>.from(state);
      final CellState updatedCell = playerMarkToCellState(event.playerMark);

      newState[event.markedCellIndex] = updatedCell;

      yield newState;
    } else if (event is PlayerWon) {
      await Future.delayed(const Duration(milliseconds: 1000));
      yield initialState;
    }
  }
}