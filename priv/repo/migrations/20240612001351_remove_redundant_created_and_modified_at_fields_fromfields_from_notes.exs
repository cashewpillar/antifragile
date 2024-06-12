defmodule Antifragile.Repo.Migrations.RemoveRedundantCreatedAndModifiedAtFieldsFromfieldsFromNotes do
  use Ecto.Migration

  def change do
    alter table(:notes) do
      remove :created_at
      remove :modified_at
    end
  end
end
