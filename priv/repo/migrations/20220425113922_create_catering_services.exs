defmodule Betachef.Repo.Migrations.CreateCateringServices do
  use Ecto.Migration

  def change do
    create table(:catering_services) do
      add :business_name, :string
      add :business_email, :string
      add :business_phone_number, :string
      add :price_per_number_of_guest, :string
      add :price_per_day, :decimal
      add :image, :string
      add :description, :string
      add :specialization, :string
      add :working_hours, :string
      add :available_days, :string
      add :caterer_id, references(:caterers, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    # create index(:caterer, [:caterer_id])
  end
end
