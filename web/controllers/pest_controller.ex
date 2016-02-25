defmodule GrowJournal.PestController do
  use GrowJournal.Web, :controller

  alias GrowJournal.Pest

  plug :scrub_params, "pest" when action in [:create, :update]

  def index(conn, _params) do
    pests = Repo.all(Pest)
    render(conn, "index.html", pests: pests)
  end

  def new(conn, _params) do
    changeset = Pest.changeset(%Pest{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"pest" => pest_params}) do
    changeset = Pest.changeset(%Pest{}, pest_params)

    case Repo.insert(changeset) do
      {:ok, _pest} ->
        conn
        |> put_flash(:info, "Pest created successfully.")
        |> redirect(to: pest_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    pest = Repo.get!(Pest, id)
    render(conn, "show.html", pest: pest)
  end

  def edit(conn, %{"id" => id}) do
    pest = Repo.get!(Pest, id)
    changeset = Pest.changeset(pest)
    render(conn, "edit.html", pest: pest, changeset: changeset)
  end

  def update(conn, %{"id" => id, "pest" => pest_params}) do
    pest = Repo.get!(Pest, id)
    changeset = Pest.changeset(pest, pest_params)

    case Repo.update(changeset) do
      {:ok, pest} ->
        conn
        |> put_flash(:info, "Pest updated successfully.")
        |> redirect(to: pest_path(conn, :show, pest))
      {:error, changeset} ->
        render(conn, "edit.html", pest: pest, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    pest = Repo.get!(Pest, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(pest)

    conn
    |> put_flash(:info, "Pest deleted successfully.")
    |> redirect(to: pest_path(conn, :index))
  end
end
