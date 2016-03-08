defmodule GrowJournal.User.PictureController do
  alias GrowJournal.Picture
  alias GrowJournal.UserPlant
  use GrowJournal.Web, :controller
  import Ecto.Model, only: [build: 2]

  plug :scrub_params, "user_plant_id"
  plug :scrub_params, "picture" when action in [:create, :update]

  def index(conn, %{"user_plant_id" => user_plant_id}) do
    pictures = Repo.all(Picture)
    user_plant = Repo.get!(UserPlant, user_plant_id)
    render(conn, "index.html", pictures: pictures, user_plant: user_plant)
  end

  def new(conn, %{"user_plant_id" => user_plant_id}) do
    changeset = Picture.changeset(%Picture{})
    user_plant = Repo.get!(UserPlant, user_plant_id)
    render(conn, "new.html", changeset: changeset, user_plant: user_plant)
  end

  def create(conn, %{"picture" => picture_params, "user_plant_id" => user_plant_id}) do
    file = picture_params["path"]
    short_path = "#{conn.assigns.current_user.id}/user_plants/#{user_plant_id}/pictures/#{file.filename}"
    full_path = System.cwd() <> "/media/" <> short_path
    picture_params = %{picture_params| "path" => short_path}
    changeset = Picture.changeset(%Picture{}, picture_params)
    user_plant = Repo.get!(UserPlant, user_plant_id)
    changeset = build(user_plant, :pictures)
      |> Picture.changeset(picture_params)

    case Repo.insert(changeset) do
      {:ok, _picture} ->
        :ok = File.cp file.path, full_path
        conn
        |> put_flash(:info, "Picture created successfully.")
        |> redirect(to: user_user_plant_path(conn, :show, user_plant_id))
      {:error, changeset} ->
        user_plant = Repo.get!(UserPlant, user_plant_id)
        render(conn, "new.html", changeset: changeset, user_plant: user_plant)
    end
  end

  def show(conn, %{"id" => id, "user_plant_id" => user_plant_id}) do
    picture = Repo.get!(Picture, id)
    user_plant = Repo.get!(UserPlant, user_plant_id)
    render(conn, "show.html", picture: picture, user_plant: user_plant)
  end

  def edit(conn, %{"id" => id, "user_plant_id" => user_plant_id}) do
    picture = Repo.get!(Picture, id)
    user_plant = Repo.get!(UserPlant, user_plant_id)
    changeset = Picture.changeset(picture)
    render(conn, "edit.html", picture: picture, changeset: changeset,
           user_plant: user_plant)
  end

  def update(conn, %{"id" => id, "picture" => picture_params, "user_plant_id" =>
                     user_plant_id}) do
    picture = Repo.get!(Picture, id)
    changeset = Picture.changeset(picture, picture_params)

    case Repo.update(changeset) do
      {:ok, picture} ->
        conn
        |> put_flash(:info, "Picture updated successfully.")
        |> redirect(to: user_user_plant_path(conn, :show, user_plant_id))
      {:error, changeset} ->
        user_plant = Repo.get!(UserPlant, user_plant_id)
        render(conn, "edit.html", picture: picture, changeset: changeset,
               user_plant: user_plant)
    end
  end

  def delete(conn, %{"id" => id, "user_plant_id" => user_plant_id}) do
    picture = Repo.get!(Picture, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(picture)

    conn
    |> put_flash(:info, "Picture deleted successfully.")
    |> redirect(to: user_user_plant_path(conn, :index))
  end
end
