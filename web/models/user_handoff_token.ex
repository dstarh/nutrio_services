
defmodule NutrioServices.UserHandoffToken do
  use Ecto.Model
  schema "user_handoff_tokens" do
    field :user_id, :integer
    field :guid, :string
    field :validated_at, Ecto.DateTime

    timestamps
  end
end