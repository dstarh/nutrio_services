defmodule NutrioServices.UserController do
  require Logger
  use NutrioServices.Web, :controller
  alias NutrioServices.Repo
  alias NutrioServices.User

  plug NutrioServices.CobrandAuth

  def index(conn, _params) do
    users = Repo.all(User)
    render conn, users: users
  end

  def show(conn, %{"id" => id}) do
    Logger.debug conn.private[:cobrand_id]
    user = Repo.get User, id
    render conn, user: user
  end

end