defmodule IaImageStorage.Repo do
  use Ecto.Repo,
    otp_app: :ia_image_storage,
    adapter: Ecto.Adapters.Postgres
end
