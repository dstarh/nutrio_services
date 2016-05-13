defmodule NutrioServices.CobrandAuth do
  import Ecto.Query
  import Plug.Conn
  require Logger
  alias NutrioServices.Repo
  alias NutrioServices.Cobrand

  def init(default), do: default

  def call(conn, _default) do
    header_content = Plug.Conn.get_req_header(conn, "authorization")

    if header_content |> valid_credentials?(conn) do
      conn
    else
      conn
      |> send_unauthorized_response
    end
  end

  defp valid_credentials?(["Basic " <> encoded_string], conn) do
    auth = Base.decode64!(encoded_string)
    [cobrand_api_key, user_api_key] = String.split(auth, ":")
    query = from c in Cobrand, where: c.api_key == ^cobrand_api_key
    cobrand = Repo.one(query)
    if nil == cobrand do
      Logger.debug "got nil for cobrand, returning false"
      conn
    else
      Logger.debug "yay we found a cobrand, putting the cobrand in the conn"
      Logger.debug cobrand.cobrand_id
      conn = Plug.Conn.put_private(conn, :cobrand_id, cobrand.cobrand_id)
      conn
    end
  end

  # Handle scenarios where there are no basic auth credentials supplied
  defp valid_credentials?(_credentials, _options) do
    false
  end

  defp send_unauthorized_response(conn) do
    Plug.Conn.put_resp_header(conn, "www-authenticate", "Basic realm=NutrioServices")
    |> Plug.Conn.send_resp(401, "401 Unauthorized")
    |> Plug.Conn.halt
  end
  
end