defmodule MoonshotPerformanceWeb.ReferralLive do
  use MoonshotPerformanceWeb, :live_view

  alias MoonshotPerformance.LeadCaptures

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:zip_code, "")
      |> assign(:email, "")

    {:ok, socket}
  end

  @impl true
  def handle_event("validate", params, socket) do
    zip_code = params["zip_code"] || ""
    email = params["email"] || ""

    socket =
      socket
      |> assign(:zip_code, zip_code)
      |> assign(:email, email)

    {:noreply, socket}
  end

  @impl true
  def handle_event("submit", _params, socket) do
    email = socket.assigns.email
    zip_code = socket.assigns.zip_code

    # Validate email is present and valid format
    cond do
      email == "" or is_nil(email) ->
        socket = put_flash(socket, :error, "Please enter your email address")
        {:noreply, socket}

      not String.match?(email, ~r/^[^\s]+@[^\s]+$/) ->
        socket = put_flash(socket, :error, "Please enter a valid email address")
        {:noreply, socket}

      true ->
        # Save to database
        attrs = %{
          email: email,
          zip_code: if(zip_code != "", do: zip_code, else: nil),
          flow_type: "need_bloodwork"
        }

        case LeadCaptures.create_lead_capture(attrs) do
          {:ok, _lead_capture} ->
            message =
              if zip_code != "" do
                "Thanks! We'll send lab information near #{zip_code} to #{email}."
              else
                "Thanks! We'll send lab information to #{email}."
              end

            socket =
              socket
              |> put_flash(:info, message)
              |> assign(:zip_code, "")
              |> assign(:email, "")

            {:noreply, socket}

          {:error, _changeset} ->
            socket = put_flash(socket, :error, "Something went wrong. Please try again.")
            {:noreply, socket}
        end
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.gradient_page>
      <div class="mx-auto max-w-2xl w-full">
        <div class="bg-white rounded-lg p-8 shadow-lg">
          <h1 class="text-3xl font-bold text-gray-900 mb-6">Find a Lab Near You</h1>

          <.flash kind={:info} flash={@flash} />
          <.flash kind={:error} flash={@flash} />

          <div class="mb-6">
            <p class="text-lg text-gray-700">
              Get your bloodwork done at a lab near you.
            </p>
          </div>

          <form phx-submit="submit" phx-change="validate" class="space-y-6">
            <div>
              <label for="zip_code" class="block text-sm font-semibold text-gray-900 mb-2">
                ZIP Code (Optional)
              </label>
              <input
                type="text"
                name="zip_code"
                id="zip_code"
                value={@zip_code}
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
                value={@email}
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
          </form>

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
    </.gradient_page>
    """
  end
end
