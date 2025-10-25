defmodule MoonshotPerformance.Repo.Migrations.CreateLeadCaptures do
  use Ecto.Migration

  def change do
    create table(:lead_captures, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string, null: false
      add :zip_code, :string
      add :flow_type, :string, null: false

      timestamps(type: :utc_datetime)
    end

    create index(:lead_captures, [:email])
    create index(:lead_captures, [:flow_type])
  end
end
