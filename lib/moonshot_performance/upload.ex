defmodule MoonshotPerformance.Upload do
  use Ecto.Schema
  import Ecto.Changeset

  schema "uploads" do
    field :email, :string
    field :file_path, :string
    field :status, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(upload, attrs) do
    upload
    |> cast(attrs, [:email, :file_path, :status])
    |> validate_required([:email, :file_path])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must be a valid email")
    |> put_status()
  end

  defp put_status(changeset) do
    if get_field(changeset, :status) do
      changeset
    else
      put_change(changeset, :status, "pending")
    end
  end
end
