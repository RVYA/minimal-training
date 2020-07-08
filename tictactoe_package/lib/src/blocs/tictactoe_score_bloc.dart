import 'package:flutter_bloc/flutter_bloc.dart';


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


class TicTacToeScoreBloc extends Bloc<ScoreEvent, Map<Side, int>> {
  @override
  Map<Side, int> get initialState => const <Side, int>{
                                      Side.x   : 0,
                                      Side.o   : 0,
                                      Side.draw: 0,
                                     };

  @override
  Stream<Map<Side, int>> mapEventToState(ScoreEvent event) async* {
    yield Map.from(state)
            ..update(
              event.winnerSide,
              (int value) => value + 1,
            );
  }
}