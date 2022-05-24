defmodule Betachef.Repo.Migrations.PaymentsAssoc do
  use Ecto.Migration

  def change do
    alter table(:payments) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :booking_id, references(:bookings, on_delete: :delete_all)
    end

    create index(:payments, [:user_id])
    create index(:payments, [:booking_id])
  end
end
