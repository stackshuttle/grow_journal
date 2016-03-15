defmodule GrowJournal.UserPlantTest do
  use GrowJournal.ModelCase

  alias GrowJournal.UserPlant

  @valid_attrs %{
    plant_id: 1,
    user_plant_id: 1,
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserPlant.changeset(%UserPlant{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserPlant.changeset(%UserPlant{}, @invalid_attrs)
    refute changeset.valid?
  end
end
