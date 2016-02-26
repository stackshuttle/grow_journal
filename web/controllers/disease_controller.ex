defmodule GrowJournal.DiseaseController do
  use GrowJournal.Web, :controller

  alias GrowJournal.Disease

  plug :scrub_params, "plant_id"
  plug :scrub_params, "disease" when action in [:create, :update]

  def index(conn, %{"plant_id" => plant_id}) do
    query = from d in Disease,               
      where: d.plant_id == ^plant_id

    diseases = Repo.all(query)
    render(conn, "index.html", diseases: diseases)
  end

  def show(conn, %{"id" => id}) do
    disease = Repo.get!(Disease, id)
    render(conn, "show.html", disease: disease)
  end
end
