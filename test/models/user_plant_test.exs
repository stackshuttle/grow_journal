defmodule GrowJournal.UserPlantTest do
  use GrowJournal.ModelCase

  alias GrowJournal.UserPlant

  @valid_attrs %{}
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
