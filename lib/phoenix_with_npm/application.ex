defmodule PhoenixWithNpm.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PhoenixWithNpmWeb.Telemetry,
      # Start the Ecto repository
      PhoenixWithNpm.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: PhoenixWithNpm.PubSub},
      # Start Finch
      {Finch, name: PhoenixWithNpm.Finch},
      # Start the Endpoint (http/https)
      PhoenixWithNpmWeb.Endpoint
      # Start a worker by calling: PhoenixWithNpm.Worker.start_link(arg)
      # {PhoenixWithNpm.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixWithNpm.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixWithNpmWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
