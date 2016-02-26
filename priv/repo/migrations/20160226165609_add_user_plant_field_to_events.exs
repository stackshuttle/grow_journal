defmodule GrowJournal.Repo.Migrations.AddUserPlantFieldToEvents do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :user_plant_id, references(:user_plants, on_delete: :nothing)
    end
    create index(:events, [:user_plant_id])
  end
end
