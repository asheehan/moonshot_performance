defmodule MoonshotPerformance.Repo.Migrations.ChangeUploadsIdToUuid do
  use Ecto.Migration

  def up do
    # Drop the existing table and recreate with UUID primary key
    drop table(:uploads)

    create table(:uploads, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string, null: false
      add :file_path, :string, null: false
      add :status, :string, null: false

      timestamps(type: :utc_datetime)
    end
  end

  def down do
    # Revert to integer primary key
    drop table(:uploads)

    create table(:uploads) do
      add :email, :string, null: false
      add :file_path, :string, null: false
      add :status, :string, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
