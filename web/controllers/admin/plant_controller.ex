defmodule GrowJournal.Admin.PlantController do
  use GrowJournal.Web, :controller

  alias GrowJournal.Plant

  plug :authenticate, "user" when action in [:index, :create, :update,
                                             :edit, :delete, :show, :new]
  plug :scrub_params, "plant" when action in [:create, :update]

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

  def index(conn, _params) do
    plants = Repo.all(Plant)
    render(conn, "index.html", plants: plants)
  end

  def new(conn, _params) do
    changeset = Plant.changeset(%Plant{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"plant" => plant_params}) do
    picture = plant_params["picture"]
    short_path = "/plants/" <> picture.filename
    full_path = System.cwd() <> "/uploads" <> short_path
    plant_params = %{plant_params| "picture" => short_path}
    changeset = Plant.changeset(%Plant{}, plant_params)


    File.cp picture.path, full_path

    case Repo.insert(changeset) do
      {:ok, plant} ->
        conn
        |> put_flash(:info, "Plant created successfully.")
        |> redirect(to: admin_plant_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    plant = Repo.get!(Plant, id)
    plant = Repo.preload plant, :diseases
    plant = Repo.preload plant, :pests
    plant = Repo.preload plant, :varieties
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
        |> redirect(to: admin_plant_path(conn, :show, plant))
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
    |> redirect(to: admin_plant_path(conn, :index))
  end
end
