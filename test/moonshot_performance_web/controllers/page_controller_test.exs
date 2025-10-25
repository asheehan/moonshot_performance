defmodule MoonshotPerformanceWeb.PageControllerTest do
  use MoonshotPerformanceWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Moonshot Performance"
  end

  test "hero section has vibrant gradient background", %{conn: conn} do
    conn = get(conn, ~p"/")
    response = html_response(conn, 200)
    assert response =~ "bg-gradient-to-br"
    assert response =~ "from-blue-500"
    assert response =~ "to-indigo-600"
  end

  test "hero section has centered content", %{conn: conn} do
    conn = get(conn, ~p"/")
    response = html_response(conn, 200)
    assert response =~ "max-w-3xl"
    assert response =~ "Moonshot Performance"
    assert response =~ "AI-powered health insights"
  end
end
