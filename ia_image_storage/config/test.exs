import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :ia_image_storage, IaImageStorage.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "ia_image_storage_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 0

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ia_image_storage, IaImageStorageWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "u5etsKiNkAsHxlb7Cv1UvPjMl8gGfR+P4fknLwBHGrA9HnxyK3bWtMXen1qhpsqC",
  server: false

# In test we don't send emails.
config :ia_image_storage, IaImageStorage.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
