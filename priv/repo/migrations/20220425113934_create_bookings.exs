defmodule Betachef.Repo.Migrations.CreateBookings do
  use Ecto.Migration

  def change do
    create table(:bookings) do
      add :start_date, :date
      add :end_date, :date
      add :booking_state, :string
      add :total_price, :decimal
      add :user_id, references(:users, on_delete: :delete_all)
      add :catering_service_id, references(:catering_services, on_delete: :delete_all)
      # add :preferences, :map
      timestamps(type: :utc_datetime)
    end
  end
end
