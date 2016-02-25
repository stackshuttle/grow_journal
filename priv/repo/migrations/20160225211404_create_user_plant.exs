defmodule GrowJournal.Repo.Migrations.CreateUserPlant do
  use Ecto.Migration

  def change do
    create table(:user_plants) do
      add :user_id, references(:users, on_delete: :nothing)
      add :plant_id, references(:plants, on_delete: :nothing)

      timestamps
    end
    create index(:user_plants, [:user_id])
    create index(:user_plants, [:plant_id])

  end
end
