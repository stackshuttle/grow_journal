defmodule GrowJournal.User.UserPlantController do
  use GrowJournal.Web, :controller

  alias GrowJournal.UserPlant
  alias GrowJournal.Plant
  alias GrowJournal.User

  import Ecto.Model, only: [build: 2]

  plug :scrub_params, "user_plant" when action in [:create, :update]
  plug :authenticate, "user" when action in [:index, :create, :update,
                                             :edit, :delete, :show, :new]

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
    query = from up in UserPlant,               
      where: up.user_id == ^conn.assigns.current_user.id
    user_plants = Repo.all(query)
                  |> Repo.preload(:plant)
    render(conn, "index.html", user_plants: user_plants)
  end

  def new(conn, _params) do
    changeset = UserPlant.changeset(%UserPlant{})
    plants = Repo.all(Plant)
    render(conn, "new.html", changeset: changeset, plants: plants)
  end

  def create(conn, %{"user_plant" => user_plant_params}) do
    user = conn.assigns.current_user
    changeset = build(user, :user_plants)
                |> UserPlant.changeset(user_plant_params)

    case Repo.insert(changeset) do
      {:ok, user_plant} ->
        conn
        |> put_flash(:info, "User plant created successfully.")
        |> redirect(to: user_user_plant_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_plant = Repo.get!(UserPlant, id)
                  |> Repo.preload(:plant)
                  |> Repo.preload(:events)
    render(conn, "show.html", user_plant: user_plant)
  end

  def edit(conn, %{"id" => id}) do
    user_plant = Repo.get!(UserPlant, id)
    plants = Repo.all(Plant)
    changeset = UserPlant.changeset(user_plant)
    render(conn, "edit.html", user_plant: user_plant, changeset: changeset,
           plants: plants)
  end

  def update(conn, %{"id" => id, "user_plant" => user_plant_params}) do
    user_plant = Repo.get!(UserPlant, id)
    changeset = UserPlant.changeset(user_plant, user_plant_params)

    case Repo.update(changeset) do
      {:ok, user_plant} ->
        conn
        |> put_flash(:info, "User plant updated successfully.")
        |> redirect(to: user_user_plant_path(conn, :show, user_plant))
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
    |> redirect(to: user_user_plant_path(conn, :index))
  end
end
