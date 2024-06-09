defmodule Antifragile.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AntifragileWeb.Telemetry,
      Antifragile.Repo,
      {DNSCluster, query: Application.get_env(:antifragile, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Antifragile.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Antifragile.Finch},
      # Start a worker by calling: Antifragile.Worker.start_link(arg)
      # {Antifragile.Worker, arg},
      # Start to serve requests, typically the last entry
      AntifragileWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Antifragile.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AntifragileWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
