defmodule SimpleServerEx.Repo do
  use Ecto.Repo,
    otp_app: :simple_server_ex,
    adapter: Ecto.Adapters.Postgres
end
