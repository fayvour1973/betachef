defmodule Betachef.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Betachef.Accounts.Payment
  alias Betachef.Catering.Booking

  schema "users" do
    field :date_of_birth, :string
    field :email, :string
    field :first_name, :string
    field :full_name, :string
    field :home_town, :string
    field :last_name, :string
    field :nationality, :string
    field :phone_number, :string
    field :residential_address, :string
    field :state_of_origin, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string

    has_many(:bookings, Booking)
    has_many(:payments, Payment)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :first_name,
      :last_name,
      :email,
      :home_town,
      :nationality,
      :date_of_birth,
      :phone_number,
      :residential_address,
      :state_of_origin,
      :full_name,
      :password,
      :password_confirmation,
      :password_hash
    ])
    |> validate_required([
      :first_name,
      :last_name,
      :email,
      :home_town,
      :nationality,
      :date_of_birth,
      :phone_number,
      :residential_address,
      :state_of_origin,
      :password,
      :password_confirmation
    ])
    |> names_concatination()
    |> hash_password()
    |> unique_constraint(:email)

    # |> validate_format(:email, ~r/@/)
  end

  defp names_concatination(changeset) do
    case changeset.valid? do
      true ->
        first_name = get_field(changeset, :first_name)
        last_name = get_field(changeset, :last_name)
        full_name = first_name <> " " <> last_name
        changeset |> put_change(:full_name, full_name)

      _ ->
        changeset
    end
  end

  defp hash_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp hash_password(changeset), do: changeset
end
