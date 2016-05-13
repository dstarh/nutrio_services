
defmodule NutrioServices.Cobrand do
  use Ecto.Model
  @derive {Poison.Encoder, only: [:cobrand_id, :api_key]}
  @primary_key {:cobrand_id, :integer, []}
  schema "cobrand_master" do
    field :api_key, :string
    has_many :users, NutrioServices.User, foreign_key: :cobrand_id
  end
end