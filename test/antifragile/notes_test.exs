defmodule Antifragile.NotesTest do
  use Antifragile.DataCase

  alias Antifragile.Notes

  describe "notes" do
    alias Antifragile.Notes.Note

    import Antifragile.NotesFixtures

    @invalid_attrs %{status: nil, title: nil, content: nil, tags: nil, reminder: nil, user_id: nil, created_at: nil, modified_at: nil}

    test "list_notes/0 returns all notes" do
      note = note_fixture()
      assert Notes.list_notes() == [note]
    end

    test "get_note!/1 returns the note with given id" do
      note = note_fixture()
      assert Notes.get_note!(note.id) == note
    end

    test "create_note/1 with valid data creates a note" do
      valid_attrs = %{status: "some status", title: "some title", content: "some content", tags: ["option1", "option2"], reminder: ~N[2024-06-08 11:45:00], user_id: 42, created_at: ~N[2024-06-08 11:45:00], modified_at: ~N[2024-06-08 11:45:00]}

      assert {:ok, %Note{} = note} = Notes.create_note(valid_attrs)
      assert note.status == "some status"
      assert note.title == "some title"
      assert note.content == "some content"
      assert note.tags == ["option1", "option2"]
      assert note.reminder == ~N[2024-06-08 11:45:00]
      assert note.user_id == 42
      assert note.created_at == ~N[2024-06-08 11:45:00]
      assert note.modified_at == ~N[2024-06-08 11:45:00]
    end

    test "create_note/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Notes.create_note(@invalid_attrs)
    end

    test "update_note/2 with valid data updates the note" do
      note = note_fixture()
      update_attrs = %{status: "some updated status", title: "some updated title", content: "some updated content", tags: ["option1"], reminder: ~N[2024-06-09 11:45:00], user_id: 43, created_at: ~N[2024-06-09 11:45:00], modified_at: ~N[2024-06-09 11:45:00]}

      assert {:ok, %Note{} = note} = Notes.update_note(note, update_attrs)
      assert note.status == "some updated status"
      assert note.title == "some updated title"
      assert note.content == "some updated content"
      assert note.tags == ["option1"]
      assert note.reminder == ~N[2024-06-09 11:45:00]
      assert note.user_id == 43
      assert note.created_at == ~N[2024-06-09 11:45:00]
      assert note.modified_at == ~N[2024-06-09 11:45:00]
    end

    test "update_note/2 with invalid data returns error changeset" do
      note = note_fixture()
      assert {:error, %Ecto.Changeset{}} = Notes.update_note(note, @invalid_attrs)
      assert note == Notes.get_note!(note.id)
    end

    test "delete_note/1 deletes the note" do
      note = note_fixture()
      assert {:ok, %Note{}} = Notes.delete_note(note)
      assert_raise Ecto.NoResultsError, fn -> Notes.get_note!(note.id) end
    end

    test "change_note/1 returns a note changeset" do
      note = note_fixture()
      assert %Ecto.Changeset{} = Notes.change_note(note)
    end
  end
end
