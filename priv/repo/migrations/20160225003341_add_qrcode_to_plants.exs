defmodule GrowJournal.Repo.Migrations.AddQrcodeToPlants do
  use Ecto.Migration

  def change do
    alter table(:plants) do
      add :qrcode_path, :string
    end
  end
end
