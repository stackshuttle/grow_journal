defmodule GrowJournal.DiseaseControllerTest do
  use GrowJournal.ConnCase

  alias GrowJournal.Disease
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, disease_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing diseases"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, disease_path(conn, :new)
    assert html_response(conn, 200) =~ "New disease"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, disease_path(conn, :create), disease: @valid_attrs
    assert redirected_to(conn) == disease_path(conn, :index)
    assert Repo.get_by(Disease, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, disease_path(conn, :create), disease: @invalid_attrs
    assert html_response(conn, 200) =~ "New disease"
  end

  test "shows chosen resource", %{conn: conn} do
    disease = Repo.insert! %Disease{}
    conn = get conn, disease_path(conn, :show, disease)
    assert html_response(conn, 200) =~ "Show disease"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, disease_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    disease = Repo.insert! %Disease{}
    conn = get conn, disease_path(conn, :edit, disease)
    assert html_response(conn, 200) =~ "Edit disease"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    disease = Repo.insert! %Disease{}
    conn = put conn, disease_path(conn, :update, disease), disease: @valid_attrs
    assert redirected_to(conn) == disease_path(conn, :show, disease)
    assert Repo.get_by(Disease, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    disease = Repo.insert! %Disease{}
    conn = put conn, disease_path(conn, :update, disease), disease: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit disease"
  end

  test "deletes chosen resource", %{conn: conn} do
    disease = Repo.insert! %Disease{}
    conn = delete conn, disease_path(conn, :delete, disease)
    assert redirected_to(conn) == disease_path(conn, :index)
    refute Repo.get(Disease, disease.id)
  end
end
