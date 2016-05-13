defmodule NutrioServices.UserHandoffTokenController do
  require Logger
  use NutrioServices.Web, :controller
  alias NutrioServices.Repo
  alias NutrioServices.User
  alias NutrioServices.UserHandoffToken

  plug NutrioServices.CobrandAuth

  def show(conn, %{"id" => id}) do
    user = Repo.get User, id
    render conn, user: user
  end

end