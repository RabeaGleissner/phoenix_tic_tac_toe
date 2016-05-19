# TicTacToe on the web!

To run this application, first clone the repo by typing:

`git clone git@github.com:RabeaGleissner/elixir_web_tic_tac_toe.git`

Now navigate into the directory and install the dependencies:

`mix deps.get`

(Give consent if it asks you to install further dependencies)

Make sure you have Postgresql installed.

Next create and migrate your database with `mix ecto.create && mix ecto.migrate`.

Start playing the game by running `mix phoenix.server`

Now you can visit [`localhost:1234`](Tic Tac Toe) from your browser.
