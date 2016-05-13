defmodule NutrioServices.UserHandoffTokenController do
  require Logger
  use NutrioServices.Web, :controller
  alias NutrioServices.Repo
  alias NutrioServices.User
  alias NutrioServices.UserHandoffToken

  plug NutrioServices.CobrandAuth

  def show(conn, %{"id" => guid}) do
    query = from t in UserHandoffToken, 
      where: t.guid == ^guid and is_nil(t.validated_at)
    token = Repo.one(query)
    if token == nil do
      conn
      |> put_status(:not_found)
    else
      token.validate!
      render conn, token: token
    end
  end

  def create(conn, _params) do
    cobrand = conn.private[:cobrand]
    Logger.debug cobrand.cobrand_id
    render conn, token: nil
  end

end