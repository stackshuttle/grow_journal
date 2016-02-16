defmodule GrowJournal.Repo.Migrations.CreatePlant do
  use Ecto.Migration

  def change do
    create table(:plants) do
      add :name, :string

      timestamps
    end

  end
end
