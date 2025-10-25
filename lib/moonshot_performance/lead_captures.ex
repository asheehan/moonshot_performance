defmodule MoonshotPerformance.LeadCaptures do
  @moduledoc """
  The LeadCaptures context.
  """

  import Ecto.Query, warn: false
  alias MoonshotPerformance.Repo
  alias MoonshotPerformance.LeadCapture

  @doc """
  Creates a lead capture.

  ## Examples

      iex> create_lead_capture(%{email: "test@example.com", flow_type: "need_bloodwork"})
      {:ok, %LeadCapture{}}

      iex> create_lead_capture(%{email: "bad"})
      {:error, %Ecto.Changeset{}}

  """
  def create_lead_capture(attrs \\ %{}) do
    %LeadCapture{}
    |> LeadCapture.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Gets a single lead capture.

  Raises `Ecto.NoResultsError` if the LeadCapture does not exist.

  ## Examples

      iex> get_lead_capture!(123)
      %LeadCapture{}

      iex> get_lead_capture!(456)
      ** (Ecto.NoResultsError)

  """
  def get_lead_capture!(id), do: Repo.get!(LeadCapture, id)

  @doc """
  Returns the list of lead captures.

  ## Examples

      iex> list_lead_captures()
      [%LeadCapture{}, ...]

  """
  def list_lead_captures do
    Repo.all(LeadCapture)
  end
end
