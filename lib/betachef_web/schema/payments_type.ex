defmodule BetachefWeb.Schema.PaymentType do
  use Absinthe.Schema.Notation

  object :payments_type do
    field :user_id, :id
    field :booking_id, :id
  end

  input_object :payments_input_type do
    field :user_id, :id
    field :booking_id, :id
  end
end
