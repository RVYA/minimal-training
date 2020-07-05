import 'package:flutter/material.dart';

import 'package:tictactoe_package/tictactoe.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: TicTacToeWidget(
            cellRadius       : 25.0,
            playerMarkRadius : 10.0,
            playerMarkStyle  : const TextStyle(
                                color     : const Color(0xFFF2F2F2),
                                fontFamily: "Chilanka",
                                fontSize  : 25.0,
                              ),
            gridLineColor    : Colors.white70,
            gridLineWidth    : 2.25,
            isGridLinesFilled: true,
            scoreTextStyle   : const TextStyle(
                                color     : const Color(0xFFF2F2F2),
                                fontFamily: "Raleway",
                                fontWeight: FontWeight.w200,
                                fontSize  : 25.0,
                              ),
            scoreboardPadding: const EdgeInsets.all(8.0),
          ),
        ),
      ),
    );
  }
}