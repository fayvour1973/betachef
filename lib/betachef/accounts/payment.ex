defmodule Betachef.Accounts.Payment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Betachef.Accounts.User
  alias Betachef.Catering.Booking

  schema "payments" do
    field :transaction_id, :integer, read_after_writes: true
    field :reference_code, :string, read_after_writes: true
    field :auth_url, :string, read_after_writes: true
    field :amount, :decimal, read_after_writes: true
    field :verified, :boolean, read_after_writes: true
    belongs_to(:user, User)
    belongs_to(:booking, Booking)
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(payment, attrs) do
    payment
    |> cast(attrs, [:user_id, :booking_id, :auth_url, :amount, :reference_code])
    |> assoc_constraint(:user)
    |> assoc_constraint(:booking)
  end

  @doc false
  def update_changeset(payment, attrs) do
    payment
    |> cast(attrs, [:transaction_id, :verified])
  end
end
