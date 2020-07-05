import 'package:flutter/material.dart';


enum CellState { empty, o, x }


const Map<CellState, String>
  _kCellStates = const <CellState, String>{
                  CellState.empty: " ",
                  CellState.o    : "O",
                  CellState.x    : "X",
                 };


class TicTacToeCell extends StatelessWidget {
  TicTacToeCell({
    @required this.cellRadius,
    @required final CellState cellState,
    @required this.markStyle,
    @required this.onPressedCallback,
  })
  : this.cellState = _kCellStates[cellState];

  final double cellRadius;
  final String cellState;
  final TextStyle markStyle;
  final VoidCallback onPressedCallback;


  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(Size.fromRadius(cellRadius)),
      child: InkWell(
        customBorder: BeveledRectangleBorder(borderRadius: BorderRadius.circular(7.5)),
        splashColor: markStyle.color.withOpacity(0.4),
        splashFactory: InkRipple.splashFactory,
        onTap: onPressedCallback,
        child: Container(
          alignment: const Alignment(0.0, 0.4),
          constraints: BoxConstraints.tight(Size.fromRadius(cellRadius)),
          child: Text( cellState,
            style: markStyle,
          ),
        ),
      ),
    );
  }
}