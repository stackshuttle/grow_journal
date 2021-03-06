defmodule GrowJournal.UserTest do
  use GrowJournal.ModelCase

  alias GrowJournal.User

  @valid_attrs %{
    email: "some content",
    username: "some content",
    password: "some password",
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
