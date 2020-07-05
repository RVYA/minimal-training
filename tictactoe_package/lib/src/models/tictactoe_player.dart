import '../widgets/tictactoe_cell.dart';


enum PlayerMark { x, o }


class TicTacToePlayer {
  const TicTacToePlayer({
    this.mark
  });

  final PlayerMark mark;
}

const TicTacToePlayer
  kPlayerX = const TicTacToePlayer(mark: PlayerMark.x),
  kPlayerO = const TicTacToePlayer(mark: PlayerMark.o);


CellState playerMarkToCellState(PlayerMark playerMark) {
  switch (playerMark) {
    case PlayerMark.x:
      return CellState.x;
    case PlayerMark.o:
      return CellState.o;
    default:
      throw Exception("This enumeration value does not exist!");
  }
}