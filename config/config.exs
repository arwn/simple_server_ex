import Config

config :simple_server_ex, SimpleServerEx.Repo,
  database: "simple_server_ex_repo",
  username: "postgres",
  password: "tsra",
  hostname: "localhost"

config :simple_server_ex, ecto_repos: [SimpleServerEx.Repo]
