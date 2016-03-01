defmodule GrowJournal.User.UserHomeController do
  use GrowJournal.Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
