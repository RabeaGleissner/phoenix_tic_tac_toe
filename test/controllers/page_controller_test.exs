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

  #use ExUnit.Case, async: true
  #use Plug.Test

  #@opts TicTacToe.Router.init([%{"board" => ["X", "X", "X", "O", "O", 6,7,8,9]}])
  #@opts TicTacToe.Router.init([])

  #test "get request to / with finished game state displays replay button" do
    #conn = with_session conn(:get, "/")
    #conn =  TicTacToe.Router.call(conn, @opts)
    #assert conn.state == :sent
    #assert String.contains?(conn.resp_body, "Play again!")
  #end

  #test "returns tic tac toe" do
    #conn = with_session conn(:get, "/")
    #conn = TicTacToe.Router.call(conn, @opts)
    #assert conn.state == :sent
  #end

  #def with_session(conn) do
    #session = Plug.Session.init(store: :cookie, key: "_tic_tac_toe_key",
    #encryption_salt: "abc", signing_salt: "abc")
    #conn
    #|> Map.put(:secret_key_base, String.duplicate("abcdefgh", 8))
    #|> Plug.Session.call(session)
    #|> Plug.Conn.fetch_session()
  #end
end
