defmodule GrowJournal.User.EventController do
  use GrowJournal.Web, :controller

  alias GrowJournal.Event
  alias GrowJournal.UserPlant
  import Ecto.Model

  plug :scrub_params, "event" when action in [:create, :update]

  def index(conn, %{"user_plant_id" => user_plant_id}) do
    events = Repo.all(Event)
    user_plant = Repo.get!(UserPlant, user_plant_id)
    render(conn, "index.html", events: events, user_plant: user_plant)
  end

  def new(conn, %{"user_plant_id" => user_plant_id}) do
    changeset = Event.changeset(%Event{})
    user_plant = Repo.get!(UserPlant, user_plant_id)
    render(conn, "new.html", changeset: changeset, user_plant: user_plant)
  end

  def create(conn, %{"event" => event_params, "user_plant_id" => user_plant_id}) do
    user_plant = Repo.get!(UserPlant, user_plant_id)
    changeset = build(user_plant, :events)
                |> Event.changeset(event_params)
    case Repo.insert(changeset) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "Event created successfully.")
        |> redirect(to: user_user_plant_event_path(conn, :show, user_plant, event))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, user_plant: user_plant)
    end
  end

  def show(conn, %{"id" => id, "user_plant_id" => user_plant_id}) do
    event = Repo.get!(Event, id)
    user_plant = Repo.get!(UserPlant, user_plant_id)
    render(conn, "show.html", event: event, user_plant: user_plant)
  end
end
