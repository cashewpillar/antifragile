defmodule AntifragileWeb.NoteControllerTest do
  use AntifragileWeb.ConnCase

  import Antifragile.NotesFixtures

  alias Antifragile.Notes.Note

  @create_attrs %{
    status: "some status",
    title: "some title",
    content: "some content",
    tags: ["option1", "option2"],
    reminder: ~N[2024-06-10 23:43:00],
    user_id: 42,
    created_at: ~N[2024-06-10 23:43:00],
    modified_at: ~N[2024-06-10 23:43:00]
  }
  @update_attrs %{
    status: "some updated status",
    title: "some updated title",
    content: "some updated content",
    tags: ["option1"],
    reminder: ~N[2024-06-11 23:43:00],
    user_id: 43,
    created_at: ~N[2024-06-11 23:43:00],
    modified_at: ~N[2024-06-11 23:43:00]
  }
  @invalid_attrs %{status: nil, title: nil, content: nil, tags: nil, reminder: nil, user_id: nil, created_at: nil, modified_at: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all notes", %{conn: conn} do
      conn = get(conn, ~p"/api/notes")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create note" do
    test "renders note when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/notes", note: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/notes/#{id}")

      assert %{
               "id" => ^id,
               "content" => "some content",
               "created_at" => "2024-06-10T23:43:00",
               "modified_at" => "2024-06-10T23:43:00",
               "reminder" => "2024-06-10T23:43:00",
               "status" => "some status",
               "tags" => ["option1", "option2"],
               "title" => "some title",
               "user_id" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/notes", note: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update note" do
    setup [:create_note]

    test "renders note when data is valid", %{conn: conn, note: %Note{id: id} = note} do
      conn = put(conn, ~p"/api/notes/#{note}", note: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/notes/#{id}")

      assert %{
               "id" => ^id,
               "content" => "some updated content",
               "created_at" => "2024-06-11T23:43:00",
               "modified_at" => "2024-06-11T23:43:00",
               "reminder" => "2024-06-11T23:43:00",
               "status" => "some updated status",
               "tags" => ["option1"],
               "title" => "some updated title",
               "user_id" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, note: note} do
      conn = put(conn, ~p"/api/notes/#{note}", note: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete note" do
    setup [:create_note]

    test "deletes chosen note", %{conn: conn, note: note} do
      conn = delete(conn, ~p"/api/notes/#{note}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/notes/#{note}")
      end
    end
  end

  defp create_note(_) do
    note = note_fixture()
    %{note: note}
  end
end
