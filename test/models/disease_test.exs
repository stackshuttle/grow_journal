defmodule GrowJournal.DiseaseTest do
  use GrowJournal.ModelCase

  alias GrowJournal.Disease

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Disease.changeset(%Disease{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Disease.changeset(%Disease{}, @invalid_attrs)
    refute changeset.valid?
  end
end
