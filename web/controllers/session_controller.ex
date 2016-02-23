defmodule GrowJournal.SessionController do
  use GrowJournal.Web, :controller

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"username" => user,
                                    "password" => password}}) do
    case GrowJournal.Auth.login_by_username_and_pass(
      conn, user, password, repo: Repo
    ) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> GrowJournal.Auth.logout()
    |> put_flash(:info, "Successfully logged out!")
    |> redirect(to: page_path(conn, :index))
  end
end
