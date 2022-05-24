defmodule Betachef.Repo.Migrations.CreatePayments do
  use Ecto.Migration

  def change do
    create table(:payments) do
      add :transaction_id, :integer
      add :reference_code, :string
      add :auth_url, :string
      add :amount, :decimal
      add :verified, :boolean
      timestamps(type: :timestamptz)
    end
  end
end
