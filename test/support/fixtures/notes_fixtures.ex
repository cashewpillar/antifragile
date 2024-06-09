defmodule Antifragile.NotesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Antifragile.Notes` context.
  """

  @doc """
  Generate a note.
  """
  def note_fixture(attrs \\ %{}) do
    {:ok, note} =
      attrs
      |> Enum.into(%{
        content: "some content",
        created_at: ~N[2024-06-08 11:45:00],
        modified_at: ~N[2024-06-08 11:45:00],
        reminder: ~N[2024-06-08 11:45:00],
        status: "some status",
        tags: ["option1", "option2"],
        title: "some title",
        user_id: 42
      })
      |> Antifragile.Notes.create_note()

    note
  end
end
