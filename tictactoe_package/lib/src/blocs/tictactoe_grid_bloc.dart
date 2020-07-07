import 'package:flutter/foundation.dart' show required;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/tictactoe_player.dart';
import '../widgets/tictactoe_cell.dart';


//region Player Events
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
//endregion


//region Tic Tac Toe Grid State
class GridState extends Equatable {
  const GridState({@required this.cellStates});

  final List<CellState> cellStates;

  @override
  List<Object> get props => <Object>[cellStates];
}

class GridInitial extends GridState {
  GridInitial()
  : super(
      cellStates: List<CellState>.filled(
                    _kTicTacToeCellCount, CellState.empty,
                  ),
    );
}
//endregion


//region Tic Tac Toe Grid BLoC
const int _kTicTacToeCellCount = 9;

class TicTacToeGridBloc extends Bloc<PlayerEvent, GridState> {
  TicTacToeGridBloc({
    GridState initialState,
  })
  : this._initialState = initialState ?? GridInitial();

  final GridState _initialState;

  @override
  GridState get initialState => _initialState;

  @override
  Stream<GridState> mapEventToState(PlayerEvent event) async* {
    if (event is PlayerPlayed) {
      final GridState newState = GridState(cellStates: state.cellStates);
      final CellState updatedCell = playerMarkToCellState(event.playerMark);
      
      newState.cellStates[event.markedCellIndex] = updatedCell;
      yield newState;
    } else if (event is PlayerWon) {
      await Future.delayed(const Duration(milliseconds: 1000));
      yield initialState;
    }
  }
}
//endregion