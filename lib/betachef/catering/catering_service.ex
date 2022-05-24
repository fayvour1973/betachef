defmodule Betachef.Catering.CateringService do
  use Ecto.Schema
  import Ecto.Changeset
  alias Betachef.Catering.Booking
  alias Betachef.Catering.Caterer

  schema "catering_services" do
    field :available_days, :string
    field :business_email, :string
    field :business_name, :string
    field :business_phone_number, :string
    field :description, :string
    field :image, :string
    field :price_per_number_of_guest, :string
    field :price_per_day, :decimal
    field :specialization, :string
    field :working_hours, :string

    has_one(:bookings, Booking)
    belongs_to(:caterer, Caterer)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(catering_service, attrs) do
    catering_service
    |> cast(attrs, [
      :business_name,
      :business_email,
      :business_phone_number,
      :price_per_number_of_guest,
      :price_per_day,
      :image,
      :description,
      :specialization,
      :working_hours,
      :available_days,
      :caterer_id
    ])
    |> validate_required([
      :business_name,
      :business_email,
      :business_phone_number,
      :price_per_number_of_guest,
      :price_per_day,
      :image,
      :description,
      :specialization,
      :working_hours,
      :available_days
    ])
    |> assoc_constraint(:caterer)
  end
end
