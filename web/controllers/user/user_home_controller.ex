defmodule GrowJournal.User.UserHomeController do
  use GrowJournal.Web, :controller

  alias GrowJournal.User
  import Comeonin.Bcrypt, only: [checkpw: 2]

  def index(conn, _params) do
    changeset = User.password_changeset(%User{}, %{})
    render(conn, "index.html")
  end

  def update_change_password(conn, %{"user" => user_params}) do
    user = Repo.get!(User, conn.assigns.current_user.id)
    changeset = User.password_changeset(user, user_params)

    if changeset.valid? && checkpw(user_params["old_password"],
                                   conn.assigns.current_user.password_hash) do
      Repo.update(changeset)
      conn
      |> put_flash(:info, "Password changed successfully!")
      |> redirect(to: user_user_home_path(conn, :index))
    else 
      conn
      |> put_flash(:error, "Invalid password combination")
      |> render("change_password.html", changeset: changeset)
    end
  end

  def change_password(conn, _params) do
    changeset = User.password_changeset(%User{})
    conn
    |> render("change_password.html", changeset: changeset)
  end

end
