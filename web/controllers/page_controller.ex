defmodule TicTacToe.PageController do
  use TicTacToe.Web, :controller

  def index(conn, _params) do
    if get_session(conn, :board) == nil do
      conn = put_session(conn, :board, Board.empty_board)
    end
    conn
    |> assign(:board, Board.empty_board)
    |> render("index.html")
  end

  def move(conn, params) do
    {_, board} = Board.place_mark(get_session(conn, :board), users_move(params))
    conn = put_session(conn, :board, board)
    conn
    |> assign(:board, board)
    |> render("index.html")
  end

  defp users_move(params) do
    {number, _} = params["move"]
                  |> Integer.parse
    number
  end
end
