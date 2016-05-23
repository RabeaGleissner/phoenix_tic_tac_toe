defmodule TicTacToe.PageControllerTest do
  use TicTacToe.ConnCase

  test "get request for / without having a board set in the session", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "<div class=\"board \">"
  end

  test "get request for /replay redirects user", %{conn: conn} do
    conn = get conn, "/replay"
    assert html_response(conn, 302)
  end
end
