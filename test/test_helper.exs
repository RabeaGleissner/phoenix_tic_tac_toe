ExUnit.start

Mix.Task.run "ecto.create", ~w(-r TicTacToe.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r TicTacToe.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(TicTacToe.Repo)

