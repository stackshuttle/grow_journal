defmodule GrowJournal.Admin.VarietyController do
  use GrowJournal.Web, :controller

  alias GrowJournal.Variety
  alias GrowJournal.Plant

  import Ecto.Model, only: [build: 2]

  plug :authenticate, "user" when action in [:index, :create, :update,
                                             :edit, :delete, :show, :new]
  plug :scrub_params, "plant_id"
  plug :scrub_params, "variety" when action in [:create, :update]

  defp authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: page_path(conn, :index))
      |> halt()
    end
  end

  def new(conn, %{"plant_id" => plant_id}) do
    changeset = Variety.changeset(%Variety{})
    plant = Repo.get!(Plant, plant_id)
    render(conn, "new.html", changeset: changeset, plant: plant)
  end

  def create(conn, %{"variety" => variety_params, "plant_id" => plant_id}) do
    changeset = Variety.changeset(%Variety{}, variety_params)
    plant = Repo.get!(Plant, plant_id)
    changeset = build(plant, :varieties)
      |> Variety.changeset(variety_params)

    case Repo.insert(changeset) do
      {:ok, _variety} ->
        conn
        |> put_flash(:info, "Variety created successfully.")
        |> redirect(to: admin_plant_path(conn, :show, plant))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id, "plant_id" => plant_id}) do
    variety = Repo.get!(Variety, id)
    plant = Repo.get!(Plant, plant_id)
    changeset = Variety.changeset(variety)
    render(conn, "edit.html", variety: variety, changeset: changeset, plant: plant)
  end

  def update(conn, %{"id" => id, "variety" => variety_params, "plant_id" =>
                     plant_id}) do
    variety = Repo.get!(Variety, id)
    changeset = Variety.changeset(variety, variety_params)

    case Repo.update(changeset) do
      {:ok, variety} ->
        conn
        |> put_flash(:info, "Variety updated successfully.")
        |> redirect(to: admin_plant_path(conn, :show, plant_id))
      {:error, changeset} ->
        render(conn, "edit.html", variety: variety, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "plant_id" => plant_id}) do
    variety = Repo.get!(Variety, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(variety)

    conn
    |> put_flash(:info, "Variety deleted successfully.")
    |> redirect(to: admin_plant_path(conn, :show, plant_id))
  end
end
