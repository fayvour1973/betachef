defmodule Betachef.Repo.Migrations.CreateCaterers do
  use Ecto.Migration

  def change do
    create table(:caterers) do
      add :first_name, :string
      add :last_name, :string
      add :full_name, :string
      add :country, :string
      add :phone_number, :string
      add :email, :string

      timestamps(type: :utc_datetime)
    end
  end
end
