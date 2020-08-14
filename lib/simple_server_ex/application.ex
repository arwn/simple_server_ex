defmodule SimpleServerEx.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: MyRouter, options: [port: 4001]},
      SimpleServerEx.Repo,
      {SimpleServerEx.Counter, 0}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SimpleServerEx.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
