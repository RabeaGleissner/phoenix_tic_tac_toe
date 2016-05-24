defmodule TicTacToe.PageControllerTest do
  use TicTacToe.ConnCase

  test "get request to root redirects user to a new game", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 302)
    assert conn.resp_body =~ "You are being <a href=\"/game/123456789\">redirected</a>"
  end

  test "get request to /game/123456789 shows an empty game board", %{conn: conn} do
    conn = get conn, "/game/123456789"
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body =~ link_to_move(1)
    assert conn.resp_body =~ link_to_move(2)
    assert conn.resp_body =~ link_to_move(3)
    assert conn.resp_body =~ link_to_move(4)
    assert conn.resp_body =~ link_to_move(5)
    assert conn.resp_body =~ link_to_move(6)
    assert conn.resp_body =~ link_to_move(7)
    assert conn.resp_body =~ link_to_move(8)
    assert conn.resp_body =~ link_to_move(9)
  end

  test "get request to /game/123456789/4 makes human and computer move on the board", %{conn: conn} do
    conn = get conn, "/game/123456789/4"
    assert conn.resp_body =~ "You are being <a href=\"/game/O23X56789\">redirected</a>"
  end

  test "get request to /game/123456789/4 redirects the user", %{conn: conn} do
    conn = get conn, "/game/123456789/4"
    assert html_response(conn, 302)
  end

  test "shows replay link when game is over", %{conn: conn} do
    conn = get conn, "/game/XXXOO6789"
    assert conn.resp_body =~ "Play again!"
  end

  test "get request for /replay redirects user to new game", %{conn: conn} do
    conn = get conn, "/replay"
    assert html_response(conn, 302)
    assert conn.resp_body =~ "You are being <a href=\"/game/123456789\">redirected</a>"
  end

  defp link_to_move(move) do
    "\"123456789/#{move}\">&nbsp;</a>"
  end
end
