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
end
