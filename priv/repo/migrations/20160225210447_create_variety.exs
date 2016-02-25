defmodule GrowJournal.Repo.Migrations.CreateVariety do
  use Ecto.Migration

  def change do
    create table(:varieties) do
      add :name, :string
      add :plant_id, references(:plants, on_delete: :nothing)

      timestamps
    end
    create index(:varieties, [:plant_id])

  end
end
