defmodule MoonshotPerformance.Repo.Migrations.CreateUploads do
  use Ecto.Migration

  def change do
    create table(:uploads) do
      add :email, :string
      add :file_path, :string
      add :status, :string

      timestamps(type: :utc_datetime)
    end
  end
end
