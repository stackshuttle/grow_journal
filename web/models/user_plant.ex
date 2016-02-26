defmodule GrowJournal.UserPlant do
  use GrowJournal.Web, :model

  schema "user_plants" do
    belongs_to :user, GrowJournal.User
    belongs_to :plant, GrowJournal.Plant
    has_many :events, GrowJournal.Event

    timestamps
  end

  @required_fields ~w(plant_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
