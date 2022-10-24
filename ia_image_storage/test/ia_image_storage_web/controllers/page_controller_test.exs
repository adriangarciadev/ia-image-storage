defmodule IaImageStorageWeb.PageControllerTest do
  use IaImageStorageWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
