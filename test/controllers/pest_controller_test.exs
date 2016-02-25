defmodule GrowJournal.PestControllerTest do
  use GrowJournal.ConnCase

  alias GrowJournal.Pest
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, pest_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing pests"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, pest_path(conn, :new)
    assert html_response(conn, 200) =~ "New pest"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, pest_path(conn, :create), pest: @valid_attrs
    assert redirected_to(conn) == pest_path(conn, :index)
    assert Repo.get_by(Pest, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, pest_path(conn, :create), pest: @invalid_attrs
    assert html_response(conn, 200) =~ "New pest"
  end

  test "shows chosen resource", %{conn: conn} do
    pest = Repo.insert! %Pest{}
    conn = get conn, pest_path(conn, :show, pest)
    assert html_response(conn, 200) =~ "Show pest"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, pest_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    pest = Repo.insert! %Pest{}
    conn = get conn, pest_path(conn, :edit, pest)
    assert html_response(conn, 200) =~ "Edit pest"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    pest = Repo.insert! %Pest{}
    conn = put conn, pest_path(conn, :update, pest), pest: @valid_attrs
    assert redirected_to(conn) == pest_path(conn, :show, pest)
    assert Repo.get_by(Pest, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    pest = Repo.insert! %Pest{}
    conn = put conn, pest_path(conn, :update, pest), pest: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit pest"
  end

  test "deletes chosen resource", %{conn: conn} do
    pest = Repo.insert! %Pest{}
    conn = delete conn, pest_path(conn, :delete, pest)
    assert redirected_to(conn) == pest_path(conn, :index)
    refute Repo.get(Pest, pest.id)
  end
end
