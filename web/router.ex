defmodule NutrioServices.Router do
  use NutrioServices.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NutrioServices do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", NutrioServices do
    pipe_through :api
    resources "/users", UserController
    resources "/user_handoff_tokens", UserHandoffTokenController
  end
end
