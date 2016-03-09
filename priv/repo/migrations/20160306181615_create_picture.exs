defmodule GrowJournal.Repo.Migrations.CreatePicture do
  use Ecto.Migration

  def change do
    create table(:pictures) do
      add :path, :string
      add :description, :string
      add :user_plant_id, references(:user_plants, on_delete: :nothing)

      timestamps
    end
    create index(:pictures, [:user_plant_id])

  end
end
