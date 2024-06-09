defmodule Antifragile.Repo.Migrations.CreateNotes do
  use Ecto.Migration

  def change do
    create table(:notes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :content, :string
      add :status, :string
      add :tags, {:array, :string}
      add :reminder, :naive_datetime
      add :user_id, :integer
      add :created_at, :naive_datetime
      add :modified_at, :naive_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
