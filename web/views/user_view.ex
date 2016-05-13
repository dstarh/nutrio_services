defmodule NutrioServices.UserView do
  use NutrioServices.Web, :view

  def render("show.json", %{user: user}) do
    user
  end
end