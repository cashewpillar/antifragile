defmodule NotesWeb.NotesController do
  use NotesWeb, :controller

  def index(conn, _params) do
    # render(conn, :index)
    json(conn, %{notes: ["Note 1", "Note 2", "Note 3"]})
  end
end
