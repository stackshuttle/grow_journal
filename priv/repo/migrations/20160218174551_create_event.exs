defmodule GrowJournal.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :when, :datetime
      add :description, :text
      add :plant_id, references(:plants, on_delete: :nothing)

      timestamps
    end
    create index(:events, [:plant_id])

  end
end
