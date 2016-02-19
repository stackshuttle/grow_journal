defmodule GrowJournal.EventController do
  use GrowJournal.Web, :controller

  alias GrowJournal.Event
  alias GrowJournal.Plant
  import Ecto.Model

  plug :scrub_params, "event" when action in [:create, :update]

  def index(conn, params) do
    query = from e in Event,
              where: e.plant_id == ^params["plant_id"]
    events = Repo.all(query)
    render(conn, "index.html", events: events, plant_id: params["plant_id"])
  end

  def new(conn, params) do
    changeset = Event.changeset(%Event{})
    render(conn, "new.html", changeset: changeset, plant_id: params["plant_id"])
  end

  def create(conn, %{"event" => event_params, "plant_id" => plant_id}) do
    {plant_id_integer, _} = to_char_list(plant_id) |> :string.to_integer
    plant = Repo.get!(Plant, plant_id)
    changeset = build(plant, :events)
      |> Event.changeset(event_params)

    case Repo.insert(changeset) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "Event created successfully.")
        |> redirect(to: plant_event_path(conn, :index, plant_id))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, plant_id: plant_id)
    end
  end

  def show(conn, %{"id" => id}) do
    event = Repo.get!(Event, id)
    render(conn, "show.html", event: event)
  end

  def edit(conn, %{"id" => id}) do
    event = Repo.get!(Event, id)
    changeset = Event.changeset(event)
    render(conn, "edit.html", event: event, changeset: changeset)
  end

  def update(conn, %{"id" => id, "event" => event_params}) do
    event = Repo.get!(Event, id)
    changeset = Event.changeset(event, event_params)

    case Repo.update(changeset) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "Event updated successfully.")
        |> redirect(to: plant_path(conn, :show, event))
      {:error, changeset} ->
        render(conn, "edit.html", event: event, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    event = Repo.get!(Event, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(event)

    conn
    |> put_flash(:info, "Event deleted successfully.")
    |> redirect(to: plant_path(conn, :index))
  end
end
