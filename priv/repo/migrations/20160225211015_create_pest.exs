defmodule GrowJournal.Repo.Migrations.CreatePest do
  use Ecto.Migration

  def change do
    create table(:pests) do
      add :name, :string
      add :plant_id, references(:plants, on_delete: :nothing)

      timestamps
    end
    create index(:pests, [:plant_id])

  end
end
