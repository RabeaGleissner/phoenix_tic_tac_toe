defmodule TicTacToe.PageController do
  use TicTacToe.Web, :controller

  def index(conn, _) do
    redirect conn, to: "/game/123456789"
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
    game_state = to_list(board)
    new_move = String.to_integer(move)
    new_game_state = Board.place_mark(game_state, new_move)
    game_state_url = convert_to_string(new_game_state)
    redirect conn, to: "/game/#{game_state_url}"
  end

  def replay(conn, _) do
    redirect conn, to: "/game/123456789"
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
