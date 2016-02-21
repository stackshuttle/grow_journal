defmodule GrowJournal.UserController do
  use GrowJournal.Web, :controller

  alias GrowJournal.User

  plug :scrub_params, "user" when action in [:create, :update]


  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "show.html", user: user)
  end

  def login(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "login.html", changeset: changeset)
  end

  def handle_login(conn, %{"user" => user_params}) do
    username = user_params["username"]
    query = from u in User,
              where: u.username == ^username
    users = Repo.all(query)
    if users != [] do
      [user|_] = users
      conn
      |> GrowJournal.Auth.login(user)
      |> put_flash(:info, "#{user.username} logged in!")
      |> redirect(to: admin_user_path(conn, :index))
    else
      conn
      |> put_flash(:error, "User not found")
      |> redirect(to: user_path(conn, :login))
    end
  end
end


