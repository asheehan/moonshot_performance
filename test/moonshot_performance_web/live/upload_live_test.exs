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
end
