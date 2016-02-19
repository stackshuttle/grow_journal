defmodule GrowJournal.EventTest do
  use GrowJournal.ModelCase

  alias GrowJournal.Event

  @valid_attrs %{description: "some content", name: "some content", when: "2010-04-17 14:00:00"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Event.changeset(%Event{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Event.changeset(%Event{}, @invalid_attrs)
    refute changeset.valid?
  end
end
