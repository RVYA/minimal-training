import 'dart:convert' as convert;

import 'package:tictactoe_package/src/blocs/tictactoe_grid_bloc.dart';
import 'package:tictactoe_package/src/blocs/tictactoe_score_bloc.dart';


const String
  _kKeyGridState  = "GridStateKey",
  _kKeyScoreState = "ScoreStateKey";


abstract class TicTacToeController {
  static String serializeGameState(GridState gridState, ScoreState scoreState) {
    Map<String, dynamic>
      stateProperties = <String, dynamic>{
                          _kKeyGridState : gridState.cellStates,
                          _kKeyScoreState: scoreState.scores,
                        };
    return convert.json.encode(stateProperties);
  }

  static dynamic deserializeGameState<T>(String gameState) {
    Map<String, dynamic> stateProperties = convert.json.decode(gameState);
    switch (T) {
      case GridState: {
        return GridState(cellStates: stateProperties[_kKeyGridState]);
      }
      case ScoreState: {
        return ScoreState(scores: stateProperties[_kKeyScoreState]);
      }
      default: {
        throw Exception("You have supplied a unrecognized class (\"${T.runtimeType}\") as type argument;"
                        "Please check your implementation. (-.-)");
      }
    }
  }
}