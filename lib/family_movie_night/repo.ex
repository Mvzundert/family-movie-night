defmodule FamilyMovieNight.Repo do
  use Ecto.Repo,
    otp_app: :family_movie_night,
    adapter: Ecto.Adapters.Postgres
end
