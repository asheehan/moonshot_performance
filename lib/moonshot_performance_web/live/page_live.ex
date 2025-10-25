defmodule MoonshotPerformanceWeb.PageLive do
  use MoonshotPerformanceWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-gradient-to-br from-blue-500 to-indigo-600 flex items-center justify-center px-4 py-12">
      <div class="mx-auto max-w-4xl w-full">
        <div class="text-center mb-12">
          <h1 class="text-5xl md:text-6xl font-bold text-white mb-6">
            Moonshot Performance
          </h1>
          <p class="text-xl md:text-2xl text-white/90">
            AI-powered health insights
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 max-w-3xl mx-auto">
          <.link
            navigate="/upload"
            class="group bg-white rounded-lg p-8 shadow-lg hover:shadow-xl transition-all duration-200 hover:scale-105 flex flex-col items-center text-center"
          >
            <div class="text-6xl mb-4">📄</div>
            <h2 class="text-2xl font-bold text-gray-900 mb-3">I Have My Bloodwork</h2>
            <p class="text-gray-600">Upload your results and get AI-powered insights</p>
          </.link>

          <.link
            navigate="/get-bloodwork"
            class="group bg-white rounded-lg p-8 shadow-lg hover:shadow-xl transition-all duration-200 hover:scale-105 flex flex-col items-center text-center"
          >
            <div class="text-6xl mb-4">🔬</div>
            <h2 class="text-2xl font-bold text-gray-900 mb-3">I Need Bloodwork</h2>
            <p class="text-gray-600">Find nearby labs to get tested</p>
          </.link>
        </div>
      </div>
    </div>
    """
  end
end
