defmodule BetachefWeb.Resolvers.Catering do
  alias Betachef.Catering
  alias Betachef.Repo
  alias Betachef.Catering.CateringService
  alias Betachef.Catering.Booking

  def list_caterers(_parent, _args, _resolution) do
    {:ok, Catering.list_caterers()}
  end

  def list_catering_services(_parent, args, _resolution) do
    {:ok, Catering.list_catering_services(args)}
  end

  def get_catering_services(_parent, %{id: id}, _resolution) do
    {:ok, Catering.get_catering_service!(id)}
  end

  def list_bookings(_parent, _args, _resolution) do
    {:ok, Catering.list_bookings()}
  end

  def create_caterers(_parent, args, _resolution) do
    Catering.create_caterer(args)
  end

  def create_catering_services(_parent, args, _resolution) do
    Catering.create_catering_service(args)
  end

  def delete_catering_services(_parent, args, _resolution) do
    catering_services = CateringService |> Repo.get(args.catering_services_id)

    case Catering.delete_catering_service(catering_services) do
      {:error, _error} -> {:error, "Catering service was not deleted"}
      {:ok, catering_services} -> {:ok, catering_services}
    end
  end

  def create_bookings(_parent, args, _resolution) do
    Catering.create_booking(args)
  end

  def delete_bookings(_parent, args, _resolution) do
    catering_services = Booking |> Repo.get(args.catering_service_id)

    case Catering.delete_booking(catering_services) do
      {:error, _error} -> {:error, "Bookings was not deleted"}
      {:ok, bookings} -> {:ok, bookings}
    end
  end

  def create_booking(_, args, %{context: %{current_user: user}}) do
    case Catering.create_booking(user, args) do
      {:ok, booking} ->
        publish_booking_change(booking)
        {:ok, booking}
    end
  end

  defp publish_booking_change(booking) do
    Absinthe.Subscription.publish(
      BetachefWeb.Endpoint,
      booking,
      booking_change: booking.catering_service_id
    )
  end
end
