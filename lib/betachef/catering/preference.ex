defmodule Betachef.Catering.Preference do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :number_of_attendees, :integer
    field :event_dress_code, :string
  end

  def changeset(preference, attrs) do
    preference
    |> cast(attrs, [:number_of_attendees, :event_dress_code])
  end
end
