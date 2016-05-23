defmodule TicTacToe.PageController do
  use TicTacToe.Web, :controller

  def index(conn, _params) do
    if get_session(conn, :board) == nil do
      conn = put_session(conn, :board, Board.empty_board)
      conn = put_session(conn, :game_over, false)
    end

    if Board.game_over?(get_session(conn, :board)) do
      conn = put_session(conn, :game_over, true)
    else
      conn = put_session(conn, :game_over, false)
    end

    conn
    |> assign(:board, get_session(conn, :board))
    |> assign(:game_over, get_session(conn, :game_over))
    |> render("index.html")
  end

  def move(conn, params) do
    {_, board} = Board.place_mark(get_session(conn, :board), users_move(params))
    conn = put_session(conn, :board, board)
    conn
    |> assign(:board, board)
    redirect conn, to: "/"
  end

  def replay(conn, params) do
      conn = put_session(conn, :board, Board.empty_board)
    |> assign(:board, Board.empty_board)
    |> assign(:game_over, get_session(conn, :game_over))
    redirect conn, to: "/"
  end

  defp users_move(params) do
    {number, _} = params["move"]
                  |> Integer.parse
    number
  end
end
