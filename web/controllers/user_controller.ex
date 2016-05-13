defmodule NutrioServices.UserController do
  require Logger
  use NutrioServices.Web, :controller
  alias NutrioServices.Repo
  alias NutrioServices.User

  plug NutrioServices.CobrandAuth

  def show(conn, %{"id" => id}) do
    user = Repo.get User, id
    render conn, user: user
  end

end