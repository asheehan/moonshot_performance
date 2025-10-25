defmodule MoonshotPerformanceWeb.UploadShowLive do
  use MoonshotPerformanceWeb, :live_view

  alias MoonshotPerformance.Uploads

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    case Uploads.get_upload!(id) do
      upload when not is_nil(upload) ->
        socket =
          socket
          |> assign(:upload, upload)

        {:ok, socket}

      nil ->
        {:ok,
         socket
         |> put_flash(:error, "Upload not found")
         |> push_navigate(to: ~p"/upload")}
    end
  rescue
    Ecto.NoResultsError ->
      {:ok,
       socket
       |> put_flash(:error, "Upload not found")
       |> push_navigate(to: ~p"/upload")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.gradient_page>
      <div class="mx-auto max-w-2xl w-full">
        <div class="bg-white rounded-lg p-8 shadow-lg">
          <h1 class="text-3xl font-bold text-gray-900 mb-6">Upload Received</h1>

          <.flash kind={:info} flash={@flash} />
          <.flash kind={:error} flash={@flash} />

          <div class="space-y-4">
            <div>
              <p class="text-lg text-gray-700">
                Thank you! We've received your bloodwork file.
              </p>
            </div>

            <div class="bg-gray-50 rounded-lg p-6 space-y-3">
              <div>
                <span class="font-semibold text-gray-900">Email:</span>
                <span class="text-gray-700 ml-2">{@upload.email}</span>
              </div>
              <div>
                <span class="font-semibold text-gray-900">Status:</span>
                <span class="text-gray-700 ml-2 capitalize">{@upload.status}</span>
              </div>
              <div>
                <span class="font-semibold text-gray-900">Uploaded:</span>
                <span class="text-gray-700 ml-2">
                  {Calendar.strftime(@upload.inserted_at, "%B %d, %Y at %I:%M %p")}
                </span>
              </div>
            </div>

            <div class="pt-4">
              <p class="text-gray-600">
                We'll analyze your results and send the insights to <span class="font-semibold">{@upload.email}</span>.
              </p>
            </div>

            <div class="pt-4">
              <.link
                navigate="/"
                class="inline-block bg-gray-600 hover:bg-gray-700 text-white font-bold py-3 px-6 rounded-lg transition-colors duration-200"
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
