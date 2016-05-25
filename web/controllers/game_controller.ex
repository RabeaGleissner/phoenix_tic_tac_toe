defmodule TicTacToe.GameController do
  use TicTacToe.Web, :controller
  @empty_board_url "/game/123456789"

  def index(conn, _) do
    redirect conn, to: @empty_board_url
  end

  def game(conn, %{"board" => board}) do
    game_state = to_list(board)
    conn
    |> assign(:board, game_state)
    |> assign(:game_over, Board.game_over?(game_state))
    |> assign(:url, board)
    |> render("index.html")
  end

  def make_move(conn, %{"board" => board, "move" => move}) do
    game_state = board
    |> to_list
    |> Board.place_mark(String.to_integer(move))
    |> play_computer_move
    |> convert_to_string
    redirect conn, to: "/game/#{game_state}"
  end

  defp play_computer_move(board) do
    unless Board.game_over?(board) do
      UnbeatablePlayer.make_move(board)
    else
      board
    end
  end

  def replay(conn, _) do
    redirect conn, to: @empty_board_url
  end

  defp convert_to_string(list) do
    Enum.join(list, "")
  end

  defp to_list(board_string) do
    board_string
    |> String.split("")
    |> List.delete("")
    |> convert_to_numbers
  end

  defp convert_to_numbers(string_list) do
    Enum.map(string_list, fn(x) ->
      if is_number?(x) do
        String.to_integer(x)
      else
        x
      end
    end)
  end

  defp is_number?(string) do
    case Float.parse(string) do
      {_num, ""} -> true
      :error     -> false
    end
  end
end
