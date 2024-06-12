defmodule Antifragile.Notes.Note do
  use Ecto.Schema
  import Ecto.Changeset
  import Logger

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "notes" do
    field :status, :string
    field :title, :string
    field :content, :string
    field :tags, {:array, :string}
    field :reminder, :naive_datetime
    field :user_id, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, [:title, :content, :status, :tags, :reminder, :user_id])
    # |> validate_required_at_least_one([:title, :content])
  end

  # defp validate_required_at_least_one(changeset, fields) do
  #   if Enum.any?(fields, fn field -> get_field(changeset, field) not in [nil, ""] end) do
  #     debug("title: #{get_field(changeset, :title)}")
  #     debug("content: #{get_field(changeset, :content)}")
  #     changeset
  #   else
  #     add_error(changeset, hd(fields), "At least one field is required")
  #   end
  # end
end
