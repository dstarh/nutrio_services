ExUnit.start

Mix.Task.run "ecto.create", ~w(-r NutrioServices.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r NutrioServices.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(NutrioServices.Repo)

