defmodule GrowJournal.UserPlantControllerTest do
  use GrowJournal.ConnCase

  alias GrowJournal.UserPlant
  @valid_attrs %{}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_plant_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing user plants"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, user_plant_path(conn, :new)
    assert html_response(conn, 200) =~ "New user plant"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, user_plant_path(conn, :create), user_plant: @valid_attrs
    assert redirected_to(conn) == user_plant_path(conn, :index)
    assert Repo.get_by(UserPlant, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_plant_path(conn, :create), user_plant: @invalid_attrs
    assert html_response(conn, 200) =~ "New user plant"
  end

  test "shows chosen resource", %{conn: conn} do
    user_plant = Repo.insert! %UserPlant{}
    conn = get conn, user_plant_path(conn, :show, user_plant)
    assert html_response(conn, 200) =~ "Show user plant"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, user_plant_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    user_plant = Repo.insert! %UserPlant{}
    conn = get conn, user_plant_path(conn, :edit, user_plant)
    assert html_response(conn, 200) =~ "Edit user plant"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    user_plant = Repo.insert! %UserPlant{}
    conn = put conn, user_plant_path(conn, :update, user_plant), user_plant: @valid_attrs
    assert redirected_to(conn) == user_plant_path(conn, :show, user_plant)
    assert Repo.get_by(UserPlant, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user_plant = Repo.insert! %UserPlant{}
    conn = put conn, user_plant_path(conn, :update, user_plant), user_plant: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit user plant"
  end

  test "deletes chosen resource", %{conn: conn} do
    user_plant = Repo.insert! %UserPlant{}
    conn = delete conn, user_plant_path(conn, :delete, user_plant)
    assert redirected_to(conn) == user_plant_path(conn, :index)
    refute Repo.get(UserPlant, user_plant.id)
  end
end
