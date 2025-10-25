defmodule MoonshotPerformance.Repo do
  use Ecto.Repo,
    otp_app: :moonshot_performance,
    adapter: Ecto.Adapters.Postgres
end
