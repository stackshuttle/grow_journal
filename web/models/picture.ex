defmodule GrowJournal.Picture do
  use GrowJournal.Web, :model

  schema "pictures" do
    field :path, :string
    field :description, :string
    belongs_to :user_plant, GrowJournal.UserPlant

    timestamps
  end

  @required_fields ~w(path description)
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

  def edit_changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(), ~w(description))
  end
end
