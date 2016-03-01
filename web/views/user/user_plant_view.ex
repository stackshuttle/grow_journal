defmodule GrowJournal.User.UserPlantView do
  use GrowJournal.Web, :view

  def number_events(plant) do
    Enum.count plant.events
  end
end
