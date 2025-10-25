defmodule MoonshotPerformanceWeb.PageLive do
  use MoonshotPerformanceWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-gradient-to-br from-blue-500 to-indigo-600 flex items-center justify-center px-4">
      <div class="mx-auto max-w-3xl text-center">
        <h1 class="text-5xl md:text-6xl font-bold text-white mb-6">
          Moonshot Performance
        </h1>
        <p class="text-xl md:text-2xl text-white/90">
          AI-powered health insights
        </p>
      </div>
    </div>
    """
  end
end
