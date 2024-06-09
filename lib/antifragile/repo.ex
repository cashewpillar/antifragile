defmodule Antifragile.Repo do
  use Ecto.Repo,
    otp_app: :antifragile,
    adapter: Ecto.Adapters.Postgres
end
