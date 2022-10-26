defmodule Terms.TermExtractor do

  @e_tag "9249-yGjEx72UH+C8PPXckOOOnGkoDUA"
  @x_cloud "f365b2f793641d4b44e96cc3fa0eb7ce"
  @url "https://openart.ai/api/feed/discovery?source=sd&cursor=30"

  def fetch_open_art_info() do
    fetch build_url()
  end

  defp build_url() do
    %{
      url: @url,
      headers: [{"etag",@e_tag}, {"x-cloud-trace-content", @x_cloud}]
    }
  end

  defp fetch(api) do
    case HTTPoison.get(api.url, api.headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, :not_found}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
