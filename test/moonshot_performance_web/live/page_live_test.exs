defmodule MoonshotPerformanceWeb.PageLiveTest do
  use MoonshotPerformanceWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected mount", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, ~p"/")
    assert disconnected_html =~ "Moonshot Performance"
    assert render(page_live) =~ "Moonshot Performance"
  end

  test "displays hero section with vibrant gradient", %{conn: conn} do
    {:ok, _page_live, html} = live(conn, ~p"/")
    assert html =~ "bg-gradient-to-br"
    assert html =~ "from-blue-500"
    assert html =~ "to-indigo-600"
  end

  test "displays AI-powered health insights subtitle", %{conn: conn} do
    {:ok, _page_live, html} = live(conn, ~p"/")
    assert html =~ "AI-powered health insights"
  end
end
