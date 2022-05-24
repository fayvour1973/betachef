defmodule Betachef.Catering.Booking do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Betachef.Accounts.{Payment, User}
  alias Betachef.Catering.CateringService
  # alias Betachef.Catering.Preference
  alias Betachef.Repo

  schema "bookings" do
    field :booking_state, :string
    field :end_date, :date
    field :start_date, :date
    field :total_price, :decimal
    # embeds_many :preferences, Preference

    belongs_to(:catering_service, CateringService)
    belongs_to(:user, User)
    has_one(:payments, Payment)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(booking, attrs) do
    booking
    |> cast(attrs, [
      :start_date,
      :end_date,
      :booking_state,
      :total_price,
      :catering_service_id,
      :user_id
    ])
    |> validate_required([
      :start_date,
      :end_date,
      :booking_state
    ])
    # |> cast_embed(:preferences, required: true)
    |> assoc_constraint(:catering_service)
    |> assoc_constraint(:user)
    |> check_catering_service_schedule()
    |> calculate_total_price()
  end

  def update_changeset(booking, attrs) do
    booking
    |> cast(attrs, [:booking_state, :catering_service_id])
    |> validate_required([:booking_state])
    |> assoc_constraint(:catering_service)
    |> calculate_total_price()
  end

  defp check_catering_service_schedule(changeset) do
    case changeset.valid? do
      true ->
        catering_service_id = get_field(changeset, :catering_service_id)

        booking_state =
          Repo.one(
            from b in __MODULE__,
              join: c in assoc(b, :catering_service),
              where: b.catering_service_id == ^catering_service_id,
              select: b.booking_state
          )

        if booking_state == "active" do
          add_error(
            changeset,
            :busy_catering_service,
            "This catering service is currently unavailable"
          )
        else
          changeset
        end

      _ ->
        changeset
    end
  end

  def calculate_total_price(changeset) do
    case changeset.valid? do
      true ->
        catering_service_id = get_field(changeset, :catering_service_id)
        end_date = get_field(changeset, :end_date)
        start_date = get_field(changeset, :start_date)

        catering_service = Repo.get(CateringService, catering_service_id)

        total_days = Date.diff(end_date, start_date)
        total_price = Decimal.mult(catering_service.price_per_day, total_days)

        put_change(changeset, :total_price, total_price)

      _ ->
        changeset
    end
  end
end
