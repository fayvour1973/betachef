defmodule BetachefWeb.Schema.BookingsType do
  use Absinthe.Schema.Notation

  object :bookings_type do
    field :id, :id
    field :end_date, :date
    field :start_date, :date
    field :booking_state, :string
    field :total_price, :decimal
    field :user_id, :id
    field :catering_service_id, :id
  end

  object :bookings1_type do
    field :id, :id
    field :end_date, :string
    field :start_date, :string
    field :booking_state, :string
  end

  input_object :bookings_input_type do
    field :id, :id
    field :end_date, :date
    field :start_date, :date
    field :booking_state, :string
    field :total_price, :decimal
    field :user_id, :id
    field :catering_service_id, :id
  end
end
