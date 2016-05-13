defmodule NutrioServices.UserHandoffTokenView do
  use NutrioServices.Web, :view

  def render("show.json", %{token: token}) do
    token
  end
  
  def render("create.json", %{token: token}) do
    token
  end
end