defmodule BetachefWeb.Schema.CaterersType do
  use Absinthe.Schema.Notation

  object :caterers_type do
    field :id, :id
    field :country, :string
    field :email, :string
    field :first_name, :string
    field :full_name, :string
    field :last_name, :string
    field :phone_number, :string
  end

  input_object :caterers_input_type do
    field :country, :string
    field :email, :string
    field :first_name, :string
    field :full_name, :string
    field :last_name, :string
    field :phone_number, :string
  end
end
