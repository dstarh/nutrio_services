defmodule NutrioServices.CobrandAuth do
  import Ecto.Query
  import Plug.Conn
  require Logger
  alias NutrioServices.Repo
  alias NutrioServices.Cobrand

  def init(default), do: default

  def call(conn, _default) do
    header_content = Plug.Conn.get_req_header(conn, "authorization")
    case valid_credentials?(header_content, conn) do
      {:ok, conn} -> conn
      {:error, conn} -> send_unauthorized_response(conn)
    end
  end

  defp valid_credentials?(["Basic " <> encoded_string], conn) do
    auth = Base.decode64!(encoded_string)
    [cobrand_api_key, user_api_key] = String.split(auth, ":")
    query = from c in Cobrand, where: c.api_key == ^cobrand_api_key
    cobrand = Repo.one(query)
    if nil == cobrand do
      {:error, conn}
    else
      {:ok, Plug.Conn.put_private(conn, :cobrand, cobrand)}
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