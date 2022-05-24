defmodule Betachef.Catering.Caterer do
  use Ecto.Schema
  import Ecto.Changeset
  alias Betachef.Catering.CateringService

  schema "caterers" do
    field :country, :string
    field :email, :string
    field :first_name, :string
    field :full_name, :string
    field :last_name, :string
    field :phone_number, :string

    has_one(:catering_services, CateringService)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(caterer, attrs) do
    caterer
    |> cast(attrs, [:first_name, :last_name, :full_name, :country, :phone_number, :email])
    |> validate_required([:first_name, :last_name, :full_name, :country, :phone_number, :email])
  end
end
