defmodule GrowJournal.UserPlantController do
  use GrowJournal.Web, :controller

  alias GrowJournal.UserPlant

  plug :scrub_params, "user_plant" when action in [:create, :update]

  def index(conn, _params) do
    user_plants = Repo.all(UserPlant)
    render(conn, "index.html", user_plants: user_plants)
  end

  def new(conn, _params) do
    changeset = UserPlant.changeset(%UserPlant{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user_plant" => user_plant_params}) do
    changeset = UserPlant.changeset(%UserPlant{}, user_plant_params)

    case Repo.insert(changeset) do
      {:ok, _user_plant} ->
        conn
        |> put_flash(:info, "User plant created successfully.")
        |> redirect(to: user_plant_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_plant = Repo.get!(UserPlant, id)
    render(conn, "show.html", user_plant: user_plant)
  end

  def edit(conn, %{"id" => id}) do
    user_plant = Repo.get!(UserPlant, id)
    changeset = UserPlant.changeset(user_plant)
    render(conn, "edit.html", user_plant: user_plant, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user_plant" => user_plant_params}) do
    user_plant = Repo.get!(UserPlant, id)
    changeset = UserPlant.changeset(user_plant, user_plant_params)

    case Repo.update(changeset) do
      {:ok, user_plant} ->
        conn
        |> put_flash(:info, "User plant updated successfully.")
        |> redirect(to: user_plant_path(conn, :show, user_plant))
      {:error, changeset} ->
        render(conn, "edit.html", user_plant: user_plant, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_plant = Repo.get!(UserPlant, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user_plant)

    conn
    |> put_flash(:info, "User plant deleted successfully.")
    |> redirect(to: user_plant_path(conn, :index))
  end
end
