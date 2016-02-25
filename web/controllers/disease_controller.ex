defmodule GrowJournal.DiseaseController do
  use GrowJournal.Web, :controller

  alias GrowJournal.Disease

  plug :scrub_params, "disease" when action in [:create, :update]

  def index(conn, _params) do
    diseases = Repo.all(Disease)
    render(conn, "index.html", diseases: diseases)
  end

  def new(conn, _params) do
    changeset = Disease.changeset(%Disease{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"disease" => disease_params}) do
    changeset = Disease.changeset(%Disease{}, disease_params)

    case Repo.insert(changeset) do
      {:ok, _disease} ->
        conn
        |> put_flash(:info, "Disease created successfully.")
        |> redirect(to: admin_disease_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
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

  def update(conn, %{"id" => id, "disease" => disease_params}) do
    disease = Repo.get!(Disease, id)
    changeset = Disease.changeset(disease, disease_params)

    case Repo.update(changeset) do
      {:ok, disease} ->
        conn
        |> put_flash(:info, "Disease updated successfully.")
        |> redirect(to: admin_disease_path(conn, :show, disease))
      {:error, changeset} ->
        render(conn, "edit.html", disease: disease, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    disease = Repo.get!(Disease, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(disease)

    conn
    |> put_flash(:info, "Disease deleted successfully.")
    |> redirect(to: admin_disease_path(conn, :index))
  end
end
