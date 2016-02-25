defmodule GrowJournal.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :when, :datetime
      add :description, :text

      timestamps
    end
  end
end
