defmodule GrowJournal.Plant do
  use GrowJournal.Web, :model

  schema "plants" do
    field :name, :string
    field :picture, :string
    field :description, :string
    has_many :diseases, GrowJournal.Disease
    has_many :pests, GrowJournal.Pest
    has_many :varieties, GrowJournal.Variety

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w(picture description)

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
