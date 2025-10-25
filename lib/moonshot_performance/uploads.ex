defmodule MoonshotPerformance.Uploads do
  @moduledoc """
  The Uploads context.
  """

  import Ecto.Query, warn: false
  alias MoonshotPerformance.Repo
  alias MoonshotPerformance.Upload

  @doc """
  Gets a single upload.

  Raises `Ecto.NoResultsError` if the Upload does not exist.

  ## Examples

      iex> get_upload!(123)
      %Upload{}

      iex> get_upload!(456)
      ** (Ecto.NoResultsError)

  """
  def get_upload!(id), do: Repo.get!(Upload, id)

  @doc """
  Creates an upload.

  ## Examples

      iex> create_upload(%{email: "test@example.com", file_path: "/uploads/file.pdf"})
      {:ok, %Upload{}}

      iex> create_upload(%{email: "bad"})
      {:error, %Ecto.Changeset{}}

  """
  def create_upload(attrs \\ %{}) do
    %Upload{}
    |> Upload.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Saves an uploaded file to the filesystem and creates an Upload record.
  """
  def save_upload(email, upload_entry) do
    # Generate UUID for unique filename
    uuid = Ecto.UUID.generate()
    ext = Path.extname(upload_entry.client_name)
    filename = "#{uuid}#{ext}"
    dest_path = Path.join(["priv", "uploads", filename])

    # Ensure uploads directory exists
    File.mkdir_p!(Path.dirname(dest_path))

    # Copy the uploaded file
    case File.cp(upload_entry.path, dest_path) do
      :ok ->
        # Create Upload record
        create_upload(%{
          email: email,
          file_path: "/uploads/#{filename}"
        })

      {:error, reason} ->
        {:error, "Failed to save file: #{inspect(reason)}"}
    end
  end
end
