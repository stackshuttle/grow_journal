defmodule GrowJournal.UserPlant do
  use GrowJournal.Web, :model

  schema "user_plants" do
    belongs_to :user, GrowJournal.User
    belongs_to :plant, GrowJournal.Plant
    has_many :events, GrowJournal.Event
    field :qrcode_path, :string

    timestamps
  end

  @required_fields ~w(plant_id)
  @optional_fields ~w(qrcode_path)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def create_qrcode(user_id, user_plant_id, url) do
    qrcode = :qrcode.encode(url)
    png = :qrcode_demo.simple_png_encode(qrcode)
    short_path = "/#{user_id}/user_plants/#{user_plant_id}.png"

    # folder to create if it doesn't exist
    folder_path = "#{System.cwd}/uploads/#{user_id}/user_plants"
    full_path = "#{folder_path}/#{user_plant_id}.png"
    if not File.exists?(folder_path) do
      File.mkdir_p(folder_path)
    end
    :ok = :file.write_file(full_path, png)
    short_path
  end
end
