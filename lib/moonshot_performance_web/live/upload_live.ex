defmodule MoonshotPerformanceWeb.UploadLive do
  use MoonshotPerformanceWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:email, "")
      |> allow_upload(:bloodwork_file,
        accept: ~w(.pdf .jpg .jpeg .png),
        max_entries: 1,
        max_file_size: 10_000_000
      )

    {:ok, socket}
  end

  @impl true
  def handle_event("validate", %{"email" => email} = _params, socket) do
    {:noreply, assign(socket, :email, email)}
  end

  @impl true
  def handle_event("submit", _params, socket) do
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-gradient-to-br from-blue-500 to-indigo-600 flex items-center justify-center px-4 py-12">
      <div class="mx-auto max-w-2xl w-full">
        <div class="bg-white rounded-lg p-8 shadow-lg">
          <h1 class="text-3xl font-bold text-gray-900 mb-6">Upload Your Bloodwork</h1>

          <form phx-submit="submit" phx-change="validate" class="space-y-6">
            <!-- Email Input -->
            <div>
              <label for="email" class="block text-sm font-semibold text-gray-900 mb-2">
                Email Address
              </label>
              <input
                type="email"
                name="email"
                id="email"
                value={@email}
                required
                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent text-gray-900"
                placeholder="your@email.com"
              />
            </div>
            
    <!-- File Upload Input -->
            <div>
              <label class="block text-sm font-semibold text-gray-900 mb-2">
                Bloodwork File
              </label>
              <div
                class="border-2 border-dashed border-gray-300 rounded-lg p-8 text-center hover:border-blue-500 transition-colors"
                phx-drop-target={@uploads.bloodwork_file.ref}
              >
                <.live_file_input upload={@uploads.bloodwork_file} class="hidden" />
                <div class="space-y-2">
                  <p class="text-gray-600">
                    Drag and drop your file here, or
                    <label
                      for={@uploads.bloodwork_file.ref}
                      class="text-blue-600 hover:text-blue-700 cursor-pointer font-semibold"
                    >
                      browse
                    </label>
                  </p>
                  <p class="text-sm text-gray-500">PDF, JPG, JPEG, or PNG (Max 10MB)</p>
                </div>
              </div>
              
    <!-- Upload Progress Bar -->
              <div :for={entry <- @uploads.bloodwork_file.entries} class="mt-4">
                <div class="flex items-center justify-between text-sm text-gray-600 mb-2">
                  <span class="font-medium">{entry.client_name}</span>
                  <span>{entry.progress}%</span>
                </div>
                <div class="w-full bg-gray-200 rounded-full h-2">
                  <div
                    class="bg-blue-600 h-2 rounded-full transition-all duration-300"
                    style={"width: #{entry.progress}%"}
                  >
                  </div>
                </div>
              </div>
            </div>
            
    <!-- Submit Button -->
            <button
              type="submit"
              class="w-full bg-blue-600 hover:bg-blue-700 text-white font-bold py-4 px-6 rounded-lg transition-colors duration-200 shadow-lg hover:shadow-xl"
            >
              Analyze My Results
            </button>
          </form>
        </div>
      </div>
    </div>
    """
  end
end
