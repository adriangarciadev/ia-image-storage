defmodule IaImageStorage.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      IaImageStorage.Repo,
      # Start the Telemetry supervisor
      IaImageStorageWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: IaImageStorage.PubSub},
      # Start the Endpoint (http/https)
      IaImageStorageWeb.Endpoint
      # Start a worker by calling: IaImageStorage.Worker.start_link(arg)
      # {IaImageStorage.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: IaImageStorage.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    IaImageStorageWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
