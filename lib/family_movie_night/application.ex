defmodule FamilyMovieNight.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FamilyMovieNightWeb.Telemetry,
      FamilyMovieNight.Repo,
      {DNSCluster,
       query: Application.get_env(:family_movie_night, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: FamilyMovieNight.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: FamilyMovieNight.Finch},
      # Start a worker by calling: FamilyMovieNight.Worker.start_link(arg)
      # {FamilyMovieNight.Worker, arg},
      # Start to serve requests, typically the last entry
      FamilyMovieNightWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FamilyMovieNight.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FamilyMovieNightWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
