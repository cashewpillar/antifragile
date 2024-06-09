defmodule Antifragile.Notes.Note do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "notes" do
    field :status, :string
    field :title, :string
    field :content, :string
    field :tags, {:array, :string}
    field :reminder, :naive_datetime
    field :user_id, :integer
    field :created_at, :naive_datetime
    field :modified_at, :naive_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, [:title, :content, :status, :tags, :reminder, :user_id, :created_at, :modified_at])
    |> validate_required([:title, :content, :status, :tags, :reminder, :user_id, :created_at, :modified_at])
  end
end
