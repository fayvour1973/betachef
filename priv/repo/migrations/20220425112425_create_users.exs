defmodule Betachef.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :home_town, :string
      add :nationality, :string
      add :date_of_birth, :string
      add :phone_number, :string
      add :residential_address, :string
      add :state_of_origin, :string
      add :full_name, :string
      add :password_hash, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, [:email])
  end
end
