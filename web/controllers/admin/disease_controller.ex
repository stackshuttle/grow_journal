defmodule GrowJournal.Admin.DiseaseController do
  use GrowJournal.Web, :controller

  alias GrowJournal.Disease
  alias GrowJournal.Plant

  import Ecto.Model, only: [build: 2]

  plug :authenticate, "user" when action in [:index, :create, :update,
                                             :edit, :delete, :show, :new]
  plug :scrub_params, "plant_id"
  plug :scrub_params, "disease" when action in [:create, :update]

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

  def index(conn, %{"plant_id" => plant_id}) do
    diseases = Repo.all(Disease)
    plant = Repo.get!(Plant, plant_id)
    render(conn, "index.html", diseases: diseases, plant: plant)
  end

  def new(conn, %{"plant_id" => plant_id}) do
    changeset = Disease.changeset(%Disease{})
    plant = Repo.get!(Plant, plant_id)
    render(conn, "new.html", changeset: changeset, plant: plant)
  end

  def create(conn, %{"disease" => disease_params, "plant_id" => plant_id}) do
    changeset = Disease.changeset(%Disease{}, disease_params)
    plant = Repo.get!(Plant, plant_id)
    changeset = build(plant, :diseases)
      |> Disease.changeset(disease_params)

    case Repo.insert(changeset) do
      {:ok, disease} ->
        conn
        |> put_flash(:info, "Disease created successfully.")
        |> redirect(to: admin_plant_path(conn, :show, plant_id))
      {:error, changeset} ->
        plant = Repo.get!(Plant, plant_id)
        render(conn, "new.html", changeset: changeset, plant: plant)
    end
  end

  def show(conn, %{"id" => id}) do
    disease = Repo.get!(Disease, id)
    render(conn, "show.html", disease: disease)
  end

  def edit(conn, %{"id" => id}) do
    disease = Repo.get!(Disease, id)
    changeset = Disease.changeset(disease)
    render(conn, "edit.html", disease: disease, changeset: changeset)
  end

  def update(conn, %{"id" => id, "disease" => disease_params, "plant_id" 
              => plant_id}) do
    disease = Repo.get!(Disease, id)
    changeset = Disease.changeset(disease, disease_params)

    case Repo.update(changeset) do
      {:ok, disease} ->
        conn
        |> put_flash(:info, "Disease updated successfully.")
        |> redirect(to: admin_plant_disease_path(conn, :show,
                                                 plant_id, disease))
      {:error, changeset} ->
        render(conn, "edit.html", disease: disease, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "plant_id" => plant_id}) do
    disease = Repo.get!(Disease, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(disease)

    conn
    |> put_flash(:info, "Disease deleted successfully.")
    |> redirect(to: admin_plant_disease_path(conn, :index, plant_id))
  end
end
