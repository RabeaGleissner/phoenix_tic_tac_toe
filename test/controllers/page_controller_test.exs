defmodule TicTacToe.PageControllerTest do
  use TicTacToe.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Tic Tac Toe"
  end
end
