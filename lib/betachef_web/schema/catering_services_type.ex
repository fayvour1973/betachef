defmodule BetachefWeb.Schema.CateringServicesType do
  use Absinthe.Schema.Notation
  # import Absinthe.Resolution.Helpers

  object :catering_services_type do
    field :id, :id
    field :available_days, :string
    field :business_email, :string
    field :business_phone_number, :string
    field :business_name, :string
    field :description, :string
    field :images, :string
    field :price_per_number_of_guest, :string
    field :price_per_day, :decimal
    field :specialization, :string
    field :working_hours, :string
    field :caterer_id, :id
    # resolve: dataloader(Catering)
    field :bookings, list_of(:bookings_type)
  end

  input_object :catering_services_input_type do
    field :available_days, :string
    field :business_email, :string
    field :business_phone_number, :string
    field :business_name, :string
    field :description, :string
    field :images, :string
    field :price_per_number_of_guest, :string
    field :price_per_day, :decimal
    field :specialization, :string
    field :working_hours, :string
    field :caterer_id, :id
  end
end
