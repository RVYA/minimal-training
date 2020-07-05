import 'package:flutter/material.dart';


const int kTicTacToeRowCount  = 3;


class TicTacToeGridFrame extends StatelessWidget {
  const TicTacToeGridFrame({
    @required this.cellRadius,
    @required this.frameColor,
    @required this.frameLineWidth,
    @required this.isFrameLineFilled,
    this.child,
  });

  final double cellRadius;
  final Color frameColor;
  final double frameLineWidth;
  final bool isFrameLineFilled;
  final Widget child;

  
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.fromRadius(kTicTacToeRowCount * cellRadius),
      foregroundPainter: TicTacToeGridFramePainter(
                          cellRadius       : cellRadius,
                          frameColor       : frameColor,
                          frameLineWidth   : frameLineWidth,
                          isFrameLineFilled: isFrameLineFilled,
                         ),
      child: child ?? null,//Container(/* EMPTY */),
    );
  }
}


class TicTacToeGridFramePainter extends ChangeNotifier implements CustomPainter {
  TicTacToeGridFramePainter({
    @required this.cellRadius,
    @required this.frameColor,
    @required this.frameLineWidth,
    @required this.isFrameLineFilled,
  });
  
  final double cellRadius;
  final Color frameColor;
  final double frameLineWidth;
  final bool isFrameLineFilled;


  @override
  void paint(Canvas canvas, Size size) {
    double cellWidth = cellRadius * 2;

    Paint paintFrame = Paint()
      ..color       = frameColor
      ..isAntiAlias = true
      ..strokeCap   = StrokeCap.round
      ..strokeJoin  = StrokeJoin.round
      ..style       = PaintingStyle.stroke
      ..strokeWidth = frameLineWidth
      ;


    canvas.drawLine(  // 1st (L) Vertical Line
      Offset(cellWidth, 0), Offset(cellWidth, size.height), paintFrame
    );
    canvas.drawLine(  // 2nd (R) Vertical Line
      Offset(2*cellWidth, size.height), Offset(2*cellWidth, 0), paintFrame
    );
    canvas.drawLine(  // 1st (T) Horizontal Line
      Offset(0, cellWidth), Offset(size.width, cellWidth), paintFrame
    );
    canvas.drawLine(  // 2nd (B) Horizontal Line
      Offset(size.width, 2*cellWidth), Offset(0, 2*cellWidth), paintFrame
    );
  }
  
  @override
  bool shouldRepaint(TicTacToeGridFramePainter oldDelegate) {
    return oldDelegate.frameColor != this.frameColor;
  }

  @override
  void dispose() => super.dispose();

  //region Not Important For Now.
  @override
  bool hitTest(Offset position) => null;

  @override
  get semanticsBuilder => null;

  @override
  bool shouldRebuildSemantics(TicTacToeGridFramePainter oldDelegate) {
    return oldDelegate.frameColor != this.frameColor;
  }
  //endregion
}