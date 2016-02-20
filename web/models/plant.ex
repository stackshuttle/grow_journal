defmodule GrowJournal.Plant do
  use GrowJournal.Web, :model

  schema "plants" do
    field :name, :string
    has_many :events, GrowJournal.Event
    field :picture, :string
    field :description, :string

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w(picture description events)

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
