defmodule GrowJournal.TestHelpers do
  alias GrowJournal.Repo

  def insert_user(attrs \\ %{}) do
    changes = Dict.merge(%{
      username: "user#{Base.encode16(:crypto.rand_bytes(8))}",
      password: "supersecret",
    }, attrs)

    %GrowJournal.User{}
    |> Rumbl.User.registration_changeset(changes)
    |> Repo.insert!()
  end

  def insert_user_plant(user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:user_plants, attrs)
    |> Repo.insert!()
  end
end
