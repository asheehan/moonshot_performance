defmodule MoonshotPerformanceWeb.UploadLive do
  use MoonshotPerformanceWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-gradient-to-br from-blue-500 to-indigo-600 flex items-center justify-center px-4 py-12">
      <div class="mx-auto max-w-2xl w-full">
        <div class="bg-white rounded-lg p-8 shadow-lg">
          <h1 class="text-3xl font-bold text-gray-900 mb-6">Upload Your Bloodwork</h1>
          <p class="text-gray-600">Upload functionality coming soon...</p>
        </div>
      </div>
    </div>
    """
  end
end
