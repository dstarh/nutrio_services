defmodule NutrioServices.PageController do
  use NutrioServices.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
