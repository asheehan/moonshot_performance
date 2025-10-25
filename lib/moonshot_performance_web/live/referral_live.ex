defmodule MoonshotPerformanceWeb.ReferralLive do
  use MoonshotPerformanceWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.gradient_page>
      <div class="mx-auto max-w-2xl w-full">
        <div class="bg-white rounded-lg p-8 shadow-lg">
          <h1 class="text-3xl font-bold text-gray-900 mb-6">Find a Lab Near You</h1>

          <div class="space-y-6">
            <div>
              <p class="text-lg text-gray-700 mb-4">
                Get your bloodwork done at a lab near you.
              </p>
            </div>

            <div>
              <label for="zip_code" class="block text-sm font-semibold text-gray-900 mb-2">
                ZIP Code (Optional)
              </label>
              <input
                type="text"
                name="zip_code"
                id="zip_code"
                placeholder="Enter ZIP code"
                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent text-gray-900"
              />
            </div>

            <div>
              <label for="email" class="block text-sm font-semibold text-gray-900 mb-2">
                Email for Reminders
              </label>
              <input
                type="email"
                name="email"
                id="email"
                required
                placeholder="your@email.com"
                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent text-gray-900"
              />
            </div>

            <button
              type="submit"
              class="w-full bg-blue-600 hover:bg-blue-700 text-white font-bold py-4 px-6 rounded-lg transition-colors duration-200 shadow-lg hover:shadow-xl"
            >
              Find Labs
            </button>

            <div class="pt-4">
              <.link
                navigate="/"
                class="inline-block text-gray-600 hover:text-gray-900 font-medium"
              >
                ← Back to Home
              </.link>
            </div>
          </div>
        </div>
      </div>
    </.gradient_page>
    """
  end
end
