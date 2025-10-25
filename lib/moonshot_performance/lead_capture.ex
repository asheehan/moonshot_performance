defmodule MoonshotPerformance.LeadCapture do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "lead_captures" do
    field :email, :string
    field :zip_code, :string
    field :flow_type, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(lead_capture, attrs) do
    lead_capture
    |> cast(attrs, [:email, :zip_code, :flow_type])
    |> validate_required([:email, :flow_type])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must be a valid email")
    |> validate_inclusion(:flow_type, ["need_bloodwork", "have_bloodwork"])
  end
end
