defmodule GrowJournal.Repo.Migrations.AddFieldsToPlants do
  use Ecto.Migration

  def change do
    alter table(:plants) do
      add :picture, :string
      add :description, :string
    end
  end
end
