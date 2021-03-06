defmodule GrowJournal.Event do
  use GrowJournal.Web, :model

  schema "events" do
    field :name, :string
    field :when, Ecto.DateTime
    field :description, :string
    belongs_to :user_plant, GrowJournal.UserPlant

    timestamps
  end

  @required_fields ~w(name when user_plant_id)
  @optional_fields ~w(description)

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
