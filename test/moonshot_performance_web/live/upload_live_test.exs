defmodule MoonshotPerformanceWeb.UploadLiveTest do
  use MoonshotPerformanceWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected mount", %{conn: conn} do
    {:ok, upload_live, disconnected_html} = live(conn, ~p"/upload")
    assert disconnected_html =~ "Upload"
    assert render(upload_live) =~ "Upload"
  end

  test "displays upload page", %{conn: conn} do
    {:ok, _upload_live, html} = live(conn, ~p"/upload")
    assert html =~ "Upload"
  end

  test "configures file upload for bloodwork", %{conn: conn} do
    {:ok, upload_live, _html} = live(conn, ~p"/upload")

    # Check that upload is configured by checking the socket state
    uploads = :sys.get_state(upload_live.pid).socket.assigns.uploads

    assert uploads.bloodwork_file != nil

    # Check max_entries is 1
    assert uploads.bloodwork_file.max_entries == 1

    # Check max_file_size is 10MB
    assert uploads.bloodwork_file.max_file_size == 10_000_000

    # Check accepted file types (stored as :any or specific list)
    accepted = uploads.bloodwork_file.accept
    # Phoenix LiveView converts the list to a comma-separated string
    assert accepted == [".pdf", ".jpg", ".jpeg", ".png"] or
             (String.contains?(accepted, ".pdf") and String.contains?(accepted, ".jpg"))
  end

  test "renders upload form with email input", %{conn: conn} do
    {:ok, _upload_live, html} = live(conn, ~p"/upload")
    assert html =~ "email"
    assert html =~ "Email"
  end

  test "email input has readable text color", %{conn: conn} do
    {:ok, _upload_live, html} = live(conn, ~p"/upload")
    # Check that the input class attribute contains text-gray-900
    assert html =~ "text-gray-900"
    # Verify it's on the email input by checking the nearby context
    assert html =~ ~r/id="email".*class="[^"]*text-gray-900/
  end

  test "renders file upload input", %{conn: conn} do
    {:ok, _upload_live, html} = live(conn, ~p"/upload")
    assert html =~ "phx-drop-target"
    assert html =~ "bloodwork_file"
  end

  test "renders submit button", %{conn: conn} do
    {:ok, _upload_live, html} = live(conn, ~p"/upload")
    assert html =~ "Analyze My Results"
  end

  test "renders upload progress bar structure", %{conn: conn} do
    {:ok, _upload_live, html} = live(conn, ~p"/upload")
    # Check that the progress bar template is present (will show when file uploaded)
    # The :for loop creates the progress bar dynamically, so check for bg-blue-600 (progress color)
    assert html =~ "bg-blue-600" or html =~ "bg-gray-200"
  end

  test "handles validate event", %{conn: conn} do
    {:ok, upload_live, _html} = live(conn, ~p"/upload")

    # Trigger validate event (form change) - should not crash
    result =
      upload_live
      |> form("form", %{email: "test@example.com"})
      |> render_change()

    # Verify the form is still rendered
    assert result =~ "Email Address"
  end

  test "handles submit event", %{conn: conn} do
    {:ok, upload_live, _html} = live(conn, ~p"/upload")

    # Submit form without file should stay on page (or show error)
    assert upload_live
           |> form("form", %{email: "test@example.com"})
           |> render_submit()
  end

  test "email persists when form is validated", %{conn: conn} do
    {:ok, upload_live, _html} = live(conn, ~p"/upload")

    # Enter email and trigger validation
    html =
      upload_live
      |> form("form", %{email: "test@example.com"})
      |> render_change()

    # Email should still be in the input value
    assert html =~ ~r/value="test@example\.com"/
  end
end
