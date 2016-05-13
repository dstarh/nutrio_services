
defmodule NutrioServices.User do
  use Ecto.Model
  @derive {Poison.Encoder, only: [:user_id, :api_key, :cobrand_id]}
  @primary_key {:user_id, :integer, []}
  schema "users_demo" do
    field :api_key, :string
    field :cobrand_id, :integer

  end
end