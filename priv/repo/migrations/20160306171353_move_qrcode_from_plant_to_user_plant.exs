defmodule GrowJournal.Repo.Migrations.MoveQrcodeFromPlantToUserPlant do
  use Ecto.Migration

  def change do
    alter table(:plants) do
      remove :qrcode_path
    end
    alter table(:user_plants) do
      add :qrcode_path, :string
    end
  end
end
