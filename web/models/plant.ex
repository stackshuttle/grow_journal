defmodule GrowJournal.Plant do
  use GrowJournal.Web, :model

  schema "plants" do
    field :name, :string
    field :picture, :string
    field :description, :string
    field :qrcode_path, :string
    has_many :diseases, GrowJournal.Disease

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w(picture description qrcode_path)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def create_qrcode(plant_id, url) do
    qrcode = :qrcode.encode(url)
    png = :qrcode_demo.simple_png_encode(qrcode)
    short_path = "/plants/test.png"
    qrcode_path = "#{System.cwd}/uploads#{short_path}"
    :ok = :file.write_file(qrcode_path, png)
    short_path
  end
end
