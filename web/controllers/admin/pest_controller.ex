defmodule GrowJournal.Admin.PestController do
  use GrowJournal.Web, :controller

  alias GrowJournal.Pest
  alias GrowJournal.Plant

  import Ecto.Model, only: [build: 2]

  plug :authenticate, "user" when action in [:index, :create, :update,
                                             :edit, :delete, :show, :new]
  plug :scrub_params, "plant_id"
  plug :scrub_params, "pest" when action in [:create, :update]

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
    changeset = Pest.changeset(%Pest{})
    plant = Repo.get!(Plant, plant_id)
    render(conn, "new.html", changeset: changeset, plant: plant)
  end

  def create(conn, %{"pest" => pest_params, "plant_id" => plant_id}) do
    changeset = Pest.changeset(%Pest{}, pest_params)
    plant = Repo.get!(Plant, plant_id)
    changeset = build(plant, :pests)
      |> Pest.changeset(pest_params)

    case Repo.insert(changeset) do
      {:ok, _pest} ->
        conn
        |> put_flash(:info, "Pest created successfully.")
        |> redirect(to: admin_plant_path(conn, :show, plant_id))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id, "plant_id" => plant_id}) do
    pest = Repo.get!(Pest, id)
    plant = Repo.get!(Plant, plant_id)
    changeset = Pest.changeset(pest)
    render(conn, "edit.html", pest: pest, changeset: changeset, plant: plant)
  end

  def update(conn, %{"id" => id, "pest" => pest_params, "plant_id" =>
                     plant_id}) do
    pest = Repo.get!(Pest, id)
    changeset = Pest.changeset(pest, pest_params)

    case Repo.update(changeset) do
      {:ok, pest} ->
        conn
        |> put_flash(:info, "Pest updated successfully.")
        |> redirect(to: admin_plant_path(conn, :show, plant_id))
      {:error, changeset} ->
        render(conn, "edit.html", pest: pest, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "plant_id" => plant_id}) do
    pest = Repo.get!(Pest, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(pest)

    conn
    |> put_flash(:info, "Pest deleted successfully.")
    |> redirect(to: admin_plant_path(conn, :show, plant_id))
  end
end
