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

  test "displays 'I Have My Bloodwork' CTA button", %{conn: conn} do
    {:ok, _page_live, html} = live(conn, ~p"/")
    assert html =~ "I Have My Bloodwork"
    assert html =~ "📄"
    assert html =~ "Upload your results and get AI-powered insights"
    assert html =~ "/upload"
  end

  test "displays 'I Need Bloodwork' CTA button", %{conn: conn} do
    {:ok, _page_live, html} = live(conn, ~p"/")
    assert html =~ "I Need Bloodwork"
    assert html =~ "🔬"
    assert html =~ "Find nearby labs to get tested"
    assert html =~ "/get-bloodwork"
  end
end
