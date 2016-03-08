defmodule GrowJournal.User.PictureController do
  alias GrowJournal.Picture
  use GrowJournal.Web, :controller
  import Ecto.Model, only: [build: 2]

  plug :scrub_params, "user_plant_id"
  plug :scrub_params, "picture" when action in [:create, :update]

  def index(conn, %{"user_plant_id" => user_plant_id}) do
    changeset = Picture.changeset(%Picture{}, %{"user_plant_id": user_plant_id})
    render(conn, "index.html")
  end

  def new(conn, %{"user_plant_id" => user_plant_id}) do
    changeset = Picture.changeset(%Picture{})
    user_plant = Repo.get!(UserPlant, user_plant_id)
    render(conn, "new.html", changeset: changeset, user_plant: user_plant)
  end

  def create(conn, %{"picture" => picture_params, "plant_id" => plant_id}) do
    changeset = Picture.changeset(%Picture{}, picture_params)
    plant = Repo.get!(Plant, plant_id)
    changeset = build(plant, :pictures)
      |> Picture.changeset(picture_params)

    case Repo.insert(changeset) do
      {:ok, _picture} ->
        conn
        |> put_flash(:info, "Picture created successfully.")
        |> redirect(to: user_plant_path(conn, :show, plant_id))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    picture = Repo.get!(Picture, id)
    render(conn, "show.html", picture: picture)
  end

  def edit(conn, %{"id" => id, "plant_id" => plant_id}) do
    picture = Repo.get!(Picture, id)
    plant = Repo.get!(Plant, plant_id)
    changeset = Picture.changeset(picture)
    render(conn, "edit.html", picture: picture, changeset: changeset, plant: plant)
  end

  def update(conn, %{"id" => id, "picture" => picture_params, "plant_id" =>
                     plant_id}) do
    picture = Repo.get!(Picture, id)
    changeset = Picture.changeset(picture, picture_params)

    case Repo.update(changeset) do
      {:ok, picture} ->
        conn
        |> put_flash(:info, "Picture updated successfully.")
        |> redirect(to: user_plant_path(conn, :show, plant_id, picture))
      {:error, changeset} ->
        render(conn, "edit.html", picture: picture, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "plant_id" => plant_id}) do
    picture = Repo.get!(Picture, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(picture)

    conn
    |> put_flash(:info, "Picture deleted successfully.")
    |> redirect(to: user_plant_path(conn, :index, plant_id))
  end
end
