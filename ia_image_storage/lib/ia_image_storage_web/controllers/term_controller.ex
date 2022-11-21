defmodule IaImageStorageWeb.TermController do
  use IaImageStorageWeb, :controller

  alias Terms.TermFormatter, as: Terms

  def index(conn, _params) do
    json(conn, Terms.get_terms())
  end
end
