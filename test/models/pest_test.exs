defmodule GrowJournal.PestTest do
  use GrowJournal.ModelCase

  alias GrowJournal.Pest

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Pest.changeset(%Pest{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Pest.changeset(%Pest{}, @invalid_attrs)
    refute changeset.valid?
  end
end
