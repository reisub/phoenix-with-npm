defmodule PhoenixWithNpm.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_with_npm,
    adapter: Ecto.Adapters.Postgres
end
