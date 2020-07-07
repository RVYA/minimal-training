import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe_package/src/widgets/announcement_button.dart';

import '../blocs/tictactoe_grid_bloc.dart';
import '../blocs/tictactoe_score_bloc.dart';
import '../models/tictactoe_player.dart';
import '../widgets/tictactoe_grid_frame.dart';
import '../widgets/tictactoe_scoreboard.dart';
import 'tictactoe_cell.dart';


const List<List<int>> kWinningPositions =
    const <List<int>>[
      <int>[0, 1, 2], //  TH
      <int>[3, 4, 5], //  MH
      <int>[6, 7, 8], //  BH
      <int>[0, 3, 6], //  LV
      <int>[1, 4, 7], //  MV
      <int>[2, 5, 8], //  RV
      <int>[0, 4, 8], //  TBD
      <int>[2, 4, 6], //  BTD
    ];


class TicTacToeGrid extends StatelessWidget {
  const TicTacToeGrid({
    @required this.cellRadius,
    this.cellOnTapCallback,
    @required this.playerMarkRadius,
    @required this.playerMarkStyle,
    @required this.frameColor,
    @required this.frameLineWidth,
    @required this.isFrameLineFilled,
    @required this.scoreTextStyle,
    @required this.scoreboardPadding,
    @required this.currentPlayer,
  });

  final double cellRadius;
  final VoidCallback cellOnTapCallback;
  final double playerMarkRadius;
  final TextStyle playerMarkStyle;
  final Color frameColor;
  final double frameLineWidth;
  final bool isFrameLineFilled;
  final TextStyle scoreTextStyle;
  final EdgeInsetsGeometry scoreboardPadding;
  final TicTacToePlayer currentPlayer;


  bool _hasPlayerWon(List<CellState> cells, PlayerMark currentPlayer) {
    final CellState stateToSearchFor = playerMarkToCellState(currentPlayer);
    bool hasCurrentPlayerWon = false;

    for (List<int> positions in kWinningPositions) {
      int matchingPositions = 0;
      
      for (int position in positions) {
        if (cells[position] == stateToSearchFor) {
          matchingPositions++;
        } else {
          break;
        }
      }

      if (matchingPositions == 3) {
        hasCurrentPlayerWon = true;
        break;
      }
    }

    return hasCurrentPlayerWon;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final TicTacToeGridBloc gridBloc =
        BlocProvider.of<TicTacToeGridBloc>(context);
    // ignore: close_sinks
    final TicTacToeScoreBloc scoreBloc =
        BlocProvider.of<TicTacToeScoreBloc>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Tic-Tac-Toe Grid
        BlocBuilder<TicTacToeGridBloc, GridState>(
          bloc   : gridBloc,
          builder: (BuildContext buildContext, GridState gridState) {
            final List<CellState> cellStates = gridState.cellStates;

            final bool isGridAtInitialState =
                !cellStates.any((CellState state) => state != CellState.empty);
            
            bool isGameCompleted = false;   // TODO: Implement reset button and highlighting.
            String announcement;

            if (!isGridAtInitialState) {
              final bool
                hasOWon = _hasPlayerWon(cellStates, PlayerMark.o),
                hasXWon = _hasPlayerWon(cellStates, PlayerMark.x),
                isGridFilled = cellStates.every(
                                (CellState cellState) => (cellState != CellState.empty)
                              ),
                isGameDraw = isGridFilled && !(hasOWon || hasXWon);

              if (hasOWon) {
                print("o won");
                scoreBloc.add(OWon());
                announcement = "O has WON!";
              } else if (hasXWon) {
                print("x won");
                scoreBloc.add(XWon());
                announcement = "X has WON!";
              } else if (isGameDraw) {
                print("draw");
                scoreBloc.add(Draw());
                announcement = "DRAW!";
              }

              isGameCompleted = (hasOWon || hasXWon || isGameDraw);
            }

            if (!isGameCompleted) {
              announcement =
                "${(currentPlayer.mark == PlayerMark.x)? "X" : "O"} is playing.";
            }

            return Column(
              children: <Widget>[
                // Announcement Button
                AnnouncementButton(
                  disabledColor    : const Color(0xFFF2F2F2).withOpacity(0.3),
                  enabledColor     : const Color(0xFFF2F2F2),
                  innerPadding     : const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                  outerPadding     : const EdgeInsets.only(bottom: 12.5),
                  text             : announcement,
                  textStyle        : scoreTextStyle.copyWith(fontSize: 15.0),
                  onPressedCallback: (isGameCompleted)?
                                      () => gridBloc.add(PlayerWon()) : null,
                ),

                // Tic-Tac-Toe Grid
                TicTacToeGridFrame(
                  cellRadius       : cellRadius,
                  frameColor       : frameColor,
                  frameLineWidth   : frameLineWidth,
                  isFrameLineFilled: isFrameLineFilled,
                  child            : ConstrainedBox(
                    constraints: BoxConstraints.tight(Size.fromRadius(kTicTacToeRowCount * cellRadius)),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: kTicTacToeRowCount
                                    ),
                      itemCount   : cellStates.length,
                      padding     : EdgeInsets.zero,
                      physics     : NeverScrollableScrollPhysics(),
                      itemBuilder : (BuildContext context, int index) {
                        final CellState state = cellStates[index];
                        final bool isCellEmpty = (state == CellState.empty);

                        return TicTacToeCell(
                          cellRadius       : cellRadius,
                          cellState        : state,
                          markStyle        : playerMarkStyle,
                          onPressedCallback: (isCellEmpty && !isGameCompleted)?
                                              () {
                                                gridBloc.add(
                                                  PlayerPlayed(
                                                    markedCellIndex: index,
                                                    playerMark: currentPlayer.mark,
                                                  ),
                                                );
                                                if (cellOnTapCallback != null) cellOnTapCallback();
                                              }
                                             : null,
                        );  
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        ),

        // Tic-Tac-Toe Scoreboard
        BlocBuilder<TicTacToeScoreBloc, ScoreState>(
          bloc   : scoreBloc,
          builder: (BuildContext buildContext, ScoreState scoreState) {
            final Map<Side, int> scores = scoreState.scores;
            return TicTacToeScoreboard(
              scoreTextStyle   : scoreTextStyle,
              scoreboardPadding: scoreboardPadding,
              xName            : "X",
              xScore           : "${scores[Side.x]}",
              oName            : "O",
              oScore           : "${scores[Side.o]}",
              drawScore        : "${scores[Side.draw]}",
            );
          } ,
        ),
      ],
    );
  }
}