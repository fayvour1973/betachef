defmodule BetachefWeb.Schema.UserType do
  use Absinthe.Schema.Notation

  object :users_type do
    field :id, :id
    field :date_of_birth, :string
    field :email, :string
    field :first_name, :string
    field :home_town, :string
    field :last_name, :string
    field :nationality, :string
    field :phone_number, :string
    field :residential_address, :string
    field :state_of_origin, :string
    field :bookings, list_of(:bookings_type)
  end

  object :session_type do
    field :token, non_null(:string)
    field :user, :users_type
  end

  input_object :users_input_type do
    field :date_of_birth, :string
    field :email, :string
    field :first_name, :string
    field :home_town, :string
    field :last_name, :string
    field :nationality, :string
    field :phone_number, :string
    field :residential_address, :string
    field :state_of_origin, :string
  end
end
