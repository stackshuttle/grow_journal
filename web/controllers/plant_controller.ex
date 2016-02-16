defmodule GrowJournal.PlantController do
  use GrowJournal.Web, :controller

  alias GrowJournal.Plant

  plug :scrub_params, "plant" when action in [:create, :update]

  def index(conn, _params) do
    plants = Repo.all(Plant)
    render(conn, "index.html", plants: plants)
  end

  def new(conn, _params) do
    changeset = Plant.changeset(%Plant{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"plant" => plant_params}) do
    changeset = Plant.changeset(%Plant{}, plant_params)

    case Repo.insert(changeset) do
      {:ok, _plant} ->
        conn
        |> put_flash(:info, "Plant created successfully.")
        |> redirect(to: plant_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    plant = Repo.get!(Plant, id)
    render(conn, "show.html", plant: plant)
  end

  def edit(conn, %{"id" => id}) do
    plant = Repo.get!(Plant, id)
    changeset = Plant.changeset(plant)
    render(conn, "edit.html", plant: plant, changeset: changeset)
  end

  def update(conn, %{"id" => id, "plant" => plant_params}) do
    plant = Repo.get!(Plant, id)
    changeset = Plant.changeset(plant, plant_params)

    case Repo.update(changeset) do
      {:ok, plant} ->
        conn
        |> put_flash(:info, "Plant updated successfully.")
        |> redirect(to: plant_path(conn, :show, plant))
      {:error, changeset} ->
        render(conn, "edit.html", plant: plant, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    plant = Repo.get!(Plant, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(plant)

    conn
    |> put_flash(:info, "Plant deleted successfully.")
    |> redirect(to: plant_path(conn, :index))
  end
end
