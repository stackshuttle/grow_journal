defmodule GrowJournal.VarietyTest do
  use GrowJournal.ModelCase

  alias GrowJournal.Variety

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Variety.changeset(%Variety{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Variety.changeset(%Variety{}, @invalid_attrs)
    refute changeset.valid?
  end
end
