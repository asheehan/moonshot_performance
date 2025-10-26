defmodule MoonshotPerformance.Release do
  @moduledoc """
  Used for executing DB release tasks when run in production without Mix
  installed.
  """
  @app :moonshot_performance

  def migrate do
    load_app()

    for repo <- repos() do
      # Retry migrations with exponential backoff for DNS propagation
      {:ok, _, _} =
        retry_with_backoff(fn ->
          Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
        end)
    end
  end

  defp retry_with_backoff(fun, retries \\ 5, base_delay \\ 1000) do
    case fun.() do
      {:ok, _, _} = result ->
        result

      {:error, reason} ->
        if retries > 0 do
          IO.puts("Migration failed (#{retries} retries left): #{inspect(reason)}")
          IO.puts("Waiting #{base_delay}ms before retry...")
          Process.sleep(base_delay)
          retry_with_backoff(fun, retries - 1, base_delay * 2)
        else
          raise "Migration failed after all retries: #{inspect(reason)}"
        end
    end
  rescue
    error ->
      if retries > 0 do
        IO.puts("Migration error (#{retries} retries left): #{inspect(error)}")
        IO.puts("Waiting #{base_delay}ms before retry...")
        Process.sleep(base_delay)
        retry_with_backoff(fun, retries - 1, base_delay * 2)
      else
        reraise error, __STACKTRACE__
      end
  end

  def rollback(repo, version) do
    load_app()
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end

  defp load_app do
    # Many platforms require SSL when connecting to the database
    Application.ensure_all_started(:ssl)
    Application.ensure_loaded(@app)
  end
end
