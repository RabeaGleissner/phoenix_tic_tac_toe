defmodule TicTacToe.PageView do
  use TicTacToe.Web, :view

  def rows do
    Board.empty_board
    |> Board.rows
  end
end
