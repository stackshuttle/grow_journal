defmodule GrowJournal.PlantController do
  use GrowJournal.Web, :controller

  alias GrowJournal.Plant

  plug :scrub_params, "plant" when action in [:create, :update]

  def index(conn, _params) do
    plants = Repo.all(Plant)
    render(conn, "index.html", plants: plants)
  end

  def show(conn, %{"id" => id}) do
    plant = Repo.get!(Plant, id)
    render(conn, "show.html", plant: plant)
  end
end
