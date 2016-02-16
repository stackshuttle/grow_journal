ExUnit.start

Mix.Task.run "ecto.create", ~w(-r GrowJournal.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r GrowJournal.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(GrowJournal.Repo)

