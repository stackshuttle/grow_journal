defmodule GrowJournal.EventController do
  use GrowJournal.Web, :controller

  alias GrowJournal.Event
  alias GrowJournal.Plant
  import Ecto.Model

  plug :scrub_params, "event" when action in [:create, :update]

  def index(conn, params) do
    events = Repo.all(Event)
    render(conn, "index.html", events: events)
  end

  def new(conn, params) do
    changeset = Event.changeset(%Event{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"event" => event_params}) do
    changeset = Event.changeset(event_params)
    case Repo.insert(changeset) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "Event created successfully.")
        |> redirect(to: event_path(conn, :show, event))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    event = Repo.get!(Event, id)
    render(conn, "show.html", event: event)
  end
end
