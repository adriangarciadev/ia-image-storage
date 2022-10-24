defmodule IaImageStorageWeb.PageController do
  use IaImageStorageWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
