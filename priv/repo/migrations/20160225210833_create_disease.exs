defmodule GrowJournal.Repo.Migrations.CreateDisease do
  use Ecto.Migration

  def change do
    create table(:diseases) do
      add :name, :string
      add :plant_id, references(:plants, on_delete: :nothing)

      timestamps
    end
    create index(:diseases, [:plant_id])

  end
end
