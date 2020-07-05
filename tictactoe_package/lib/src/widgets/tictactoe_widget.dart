import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/tictactoe_grid_bloc.dart';
import '../blocs/tictactoe_score_bloc.dart';
import '../models/tictactoe_player.dart';
import 'tictactoe_grid.dart';


class TicTacToeWidget extends StatefulWidget {
  const TicTacToeWidget({
    @required this.cellRadius,
    @required this.playerMarkStyle,
    @required this.playerMarkRadius,
    @required this.gridLineColor,
    @required this.gridLineWidth,
    @required this.isGridLinesFilled,
    @required this.scoreTextStyle,
    @required this.scoreboardPadding,
  });

  final double cellRadius;
  final TextStyle playerMarkStyle;
  final double playerMarkRadius;
  final Color gridLineColor;
  final double gridLineWidth;
  final bool isGridLinesFilled;
  final TextStyle scoreTextStyle;
  final EdgeInsetsGeometry scoreboardPadding;


  @override
  _TicTacToeWidgetState createState() => _TicTacToeWidgetState();
}

class _TicTacToeWidgetState extends State<TicTacToeWidget> {
  TicTacToePlayer
    firstPlayer, secondPlayer;
  TicTacToePlayer currentPlayer;

  @override
  void initState() {
    super.initState();

    final bool isXFirst = (math.Random().nextDouble() < 0.5);
    firstPlayer = (isXFirst)? kPlayerX : kPlayerO;
    secondPlayer = (isXFirst)? kPlayerO : kPlayerX;

    currentPlayer = firstPlayer;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<TicTacToeGridBloc>(
          create: (BuildContext context) => TicTacToeGridBloc(),
        ),
        BlocProvider<TicTacToeScoreBloc>(
          create: (BuildContext context) => TicTacToeScoreBloc(),
        ),
      ],
      child: TicTacToeGrid(
        cellOnTapCallback: () => setState(() {
                                  currentPlayer =
                                    (currentPlayer == firstPlayer)?
                                      secondPlayer : firstPlayer;
                                 }),
        cellRadius       : widget.cellRadius,
        playerMarkRadius : widget.playerMarkRadius,
        playerMarkStyle  : widget.playerMarkStyle,
        frameColor       : widget.gridLineColor,
        frameLineWidth   : widget.gridLineWidth,
        isFrameLineFilled: widget.isGridLinesFilled,
        scoreTextStyle   : widget.scoreTextStyle,
        currentPlayer    : currentPlayer,
        scoreboardPadding: widget.scoreboardPadding,
      ),
    );
  }
}