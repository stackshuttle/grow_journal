defmodule GrowJournal.PlantTest do
  use GrowJournal.ModelCase

  alias GrowJournal.Plant

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Plant.changeset(%Plant{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Plant.changeset(%Plant{}, @invalid_attrs)
    refute changeset.valid?
  end
end
