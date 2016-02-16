defmodule GrowJournal.PlantControllerTest do
  use GrowJournal.ConnCase

  alias GrowJournal.Plant
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, plant_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing plants"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, plant_path(conn, :new)
    assert html_response(conn, 200) =~ "New plant"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, plant_path(conn, :create), plant: @valid_attrs
    assert redirected_to(conn) == plant_path(conn, :index)
    assert Repo.get_by(Plant, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, plant_path(conn, :create), plant: @invalid_attrs
    assert html_response(conn, 200) =~ "New plant"
  end

  test "shows chosen resource", %{conn: conn} do
    plant = Repo.insert! %Plant{}
    conn = get conn, plant_path(conn, :show, plant)
    assert html_response(conn, 200) =~ "Show plant"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, plant_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    plant = Repo.insert! %Plant{}
    conn = get conn, plant_path(conn, :edit, plant)
    assert html_response(conn, 200) =~ "Edit plant"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    plant = Repo.insert! %Plant{}
    conn = put conn, plant_path(conn, :update, plant), plant: @valid_attrs
    assert redirected_to(conn) == plant_path(conn, :show, plant)
    assert Repo.get_by(Plant, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    plant = Repo.insert! %Plant{}
    conn = put conn, plant_path(conn, :update, plant), plant: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit plant"
  end

  test "deletes chosen resource", %{conn: conn} do
    plant = Repo.insert! %Plant{}
    conn = delete conn, plant_path(conn, :delete, plant)
    assert redirected_to(conn) == plant_path(conn, :index)
    refute Repo.get(Plant, plant.id)
  end
end
