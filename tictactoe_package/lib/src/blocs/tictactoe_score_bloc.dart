import 'package:flutter/foundation.dart' show required;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


//region Score Events
enum Side { x, o, draw }


abstract class ScoreEvent {
  const ScoreEvent({this.winnerSide});

  final Side winnerSide;
}

class XWon extends ScoreEvent {
  const XWon() : super(winnerSide: Side.x);
}

class OWon extends ScoreEvent {
  const OWon() : super(winnerSide: Side.o);
}

class Draw extends ScoreEvent {
  const Draw() : super(winnerSide: Side.draw);
}
//endregion


//region Tic Tac Toe Score State
class ScoreState extends Equatable {
  const ScoreState({@required this.scores});
  
  final Map<Side, int> scores;

  @override
  List<Object> get props => <Object>[scores];
}

class ScoreInitial extends ScoreState {
  const ScoreInitial()
  : super(
      scores: const <Side, int>{
                      Side.x   : 0,
                      Side.o   : 0,
                      Side.draw: 0,
                    }
    );
}
//endregion


//region Tic Tac Toe Score BLoC
class TicTacToeScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  TicTacToeScoreBloc({ScoreState initialState,})
  : this._initialState = initialState ?? ScoreInitial();

  final ScoreState _initialState;
  
  @override
  ScoreState get initialState => _initialState;

  @override
  Stream<ScoreState> mapEventToState(ScoreEvent event) async* {
    yield
      ScoreState(
        scores: Map.from(state.scores)
                  ..update(
                    event.winnerSide,
                    (int value) => value + 1,
                  )
      );
  }
}
//endregion