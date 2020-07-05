import 'package:flutter/material.dart';


class TicTacToeScoreboard extends StatelessWidget {
  TicTacToeScoreboard({
    @required this.scoreTextStyle,
    @required this.scoreboardPadding,
    @required this.xName,
    @required this.xScore,
    @required this.oName,
    @required this.oScore,
    @required this.drawScore,
  });
  
  final TextStyle scoreTextStyle;
  final EdgeInsetsGeometry scoreboardPadding;
  final String
    xName, xScore,
    oName, oScore,
    drawScore;


  RichText generateScoreText(String name, String score, {bool isDim = false}) {
    final TextStyle dimmedScoreTextStyle = scoreTextStyle.copyWith(
                                            color: scoreTextStyle.color.withOpacity(0.7)
                                           );
    
    return
      RichText(
        textAlign: TextAlign.center,
        text     : TextSpan(
                    text    : "$name\n",
                    style   : (isDim)? scoreTextStyle : dimmedScoreTextStyle,
                    children: <TextSpan>[
                                TextSpan(
                                  style: (isDim)? dimmedScoreTextStyle : scoreTextStyle,
                                  text: score,
                                ),
                              ],
                   ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: scoreboardPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // X's Score
          generateScoreText(xName, xScore),

          // Draw Score
          generateScoreText("DRAW", drawScore, isDim: true),

          // O's Score
          generateScoreText(oName, oScore),
        ],
      ),
    );
  }
}