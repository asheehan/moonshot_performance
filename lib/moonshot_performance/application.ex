defmodule MoonshotPerformance.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # Ensure uploads directory exists
    uploads_dir = Path.join([:code.priv_dir(:moonshot_performance), "uploads"])
    File.mkdir_p!(uploads_dir)

    children = [
      MoonshotPerformanceWeb.Telemetry,
      MoonshotPerformance.Repo,
      {DNSCluster,
       query: Application.get_env(:moonshot_performance, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MoonshotPerformance.PubSub},
      # Start a worker by calling: MoonshotPerformance.Worker.start_link(arg)
      # {MoonshotPerformance.Worker, arg},
      # Start to serve requests, typically the last entry
      MoonshotPerformanceWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MoonshotPerformance.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MoonshotPerformanceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
