defmodule TicTacToe.PageController do
  use TicTacToe.Web, :controller

  def index(conn, _) do
    conn = update_session(conn)
    conn = clear_session_on_game_over(conn)

    conn
    |> assign(:board, get_session(conn, :board))
    |> assign(:game_over, get_session(conn, :game_over))
    |> render("index.html")
  end

  def move(conn, params) do
    board = Board.place_mark(get_session(conn, :board), users_move(params))
    if Board.game_over?(board) do
      new_board = board
    else
      new_board = UnbeatablePlayer.make_move(board)
    end
    conn = put_session(conn, :board, new_board)
    conn
    |> assign(:board, board)
    redirect conn, to: "/"
  end

  def replay(conn, _) do
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

  defp clear_session_on_game_over(conn) do
    if Board.game_over?(get_session(conn, :board)) do
      conn = put_session(conn, :game_over, true)
    else
      conn = put_session(conn, :game_over, false)
    end
    conn
  end

  defp update_session(conn) do
    if get_session(conn, :board) == nil do
      conn = put_session(conn, :board, Board.empty_board)
      conn = put_session(conn, :game_over, false)
    end
    conn
  end
end
