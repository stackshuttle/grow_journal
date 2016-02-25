defmodule GrowJournal.VarietyController do
  use GrowJournal.Web, :controller

  alias GrowJournal.Variety

  plug :scrub_params, "variety" when action in [:create, :update]

  def index(conn, _params) do
    varieties = Repo.all(Variety)
    render(conn, "index.html", varieties: varieties)
  end

  def new(conn, _params) do
    changeset = Variety.changeset(%Variety{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"variety" => variety_params}) do
    changeset = Variety.changeset(%Variety{}, variety_params)

    case Repo.insert(changeset) do
      {:ok, _variety} ->
        conn
        |> put_flash(:info, "Variety created successfully.")
        |> redirect(to: admin_variety_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    variety = Repo.get!(Variety, id)
    render(conn, "show.html", variety: variety)
  end

  def edit(conn, %{"id" => id}) do
    variety = Repo.get!(Variety, id)
    changeset = Variety.changeset(variety)
    render(conn, "edit.html", variety: variety, changeset: changeset)
  end

  def update(conn, %{"id" => id, "variety" => variety_params}) do
    variety = Repo.get!(Variety, id)
    changeset = Variety.changeset(variety, variety_params)

    case Repo.update(changeset) do
      {:ok, variety} ->
        conn
        |> put_flash(:info, "Variety updated successfully.")
        |> redirect(to: admin_variety_path(conn, :show, variety))
      {:error, changeset} ->
        render(conn, "edit.html", variety: variety, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    variety = Repo.get!(Variety, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(variety)

    conn
    |> put_flash(:info, "Variety deleted successfully.")
    |> redirect(to: admin_variety_path(conn, :index))
  end
end
