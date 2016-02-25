defmodule GrowJournal.VarietyControllerTest do
  use GrowJournal.ConnCase

  alias GrowJournal.Variety
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, variety_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing varieties"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, variety_path(conn, :new)
    assert html_response(conn, 200) =~ "New variety"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, variety_path(conn, :create), variety: @valid_attrs
    assert redirected_to(conn) == variety_path(conn, :index)
    assert Repo.get_by(Variety, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, variety_path(conn, :create), variety: @invalid_attrs
    assert html_response(conn, 200) =~ "New variety"
  end

  test "shows chosen resource", %{conn: conn} do
    variety = Repo.insert! %Variety{}
    conn = get conn, variety_path(conn, :show, variety)
    assert html_response(conn, 200) =~ "Show variety"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, variety_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    variety = Repo.insert! %Variety{}
    conn = get conn, variety_path(conn, :edit, variety)
    assert html_response(conn, 200) =~ "Edit variety"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    variety = Repo.insert! %Variety{}
    conn = put conn, variety_path(conn, :update, variety), variety: @valid_attrs
    assert redirected_to(conn) == variety_path(conn, :show, variety)
    assert Repo.get_by(Variety, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    variety = Repo.insert! %Variety{}
    conn = put conn, variety_path(conn, :update, variety), variety: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit variety"
  end

  test "deletes chosen resource", %{conn: conn} do
    variety = Repo.insert! %Variety{}
    conn = delete conn, variety_path(conn, :delete, variety)
    assert redirected_to(conn) == variety_path(conn, :index)
    refute Repo.get(Variety, variety.id)
  end
end
