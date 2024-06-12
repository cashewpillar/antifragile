defmodule AntifragileWeb.NoteJSON do
  alias Antifragile.Notes.Note

  @doc """
  Renders a list of notes.
  """
  def index(%{notes: notes}) do
    %{data: for(note <- notes, do: data(note))}
  end

  @doc """
  Renders a single note.
  """
  def show(%{note: note}) do
    %{data: data(note)}
  end

  defp data(%Note{} = note) do
    %{
      id: note.id,
      title: note.title,
      content: note.content,
      status: note.status,
      tags: note.tags,
      reminder: note.reminder,
      user_id: note.user_id,
      created_at: note.created_at,
      modified_at: note.modified_at
    }
  end
end
