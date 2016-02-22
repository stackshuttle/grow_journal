defmodule GrowJournal.Auth do
  import Plug.Conn

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    user_id = get_session(conn, :user_id)
    user = user_id && repo.get(GrowJournal.User, user_id)
    assign(conn, :current_user, user)
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end

  def login_by_username_and_pass(conn, username, opts) do
    repo = Keyword.fetch!(opts, :repo)
    user = repo.get_by(GrowJournal.User, username: username)

    cond do
      user ->
        {:ok, login(conn, user)}
      true ->
        {:error, :not_found, conn}
    end
  end
end
